# Phase 1 - ACI Basics with NetasCode

## Objective

This document is the foundation for learning Cisco ACI and enhancing the NetasCode ACI example.

Repository:

https://github.com/amitgupta369/nac-aci-simple-example

Goal:

Build a simple **HR application network** in ACI using NetasCode.

---

# ACI Flow

```text
Tenant → VRF → Bridge Domain → Subnet → App Profile → EPG → Contract
```

Hierarchy:

```text
Tenant
 └── VRF
      └── Bridge Domain
           └── Subnet

App Profile
 └── EPG

Contract
```

---

# AWS Mapping

Easy mapping for AWS understanding:

| ACI           | AWS                        |
| ------------- | -------------------------- |
| Tenant        | AWS Account / Environment  |
| VRF           | VPC                        |
| Bridge Domain | Subnet                     |
| Subnet        | CIDR Block                 |
| App Profile   | Application Group          |
| EPG           | EC2 Group / Security Group |
| Contract      | Security Group Rules       |

---

# Core ACI Components

## 1. Tenant

Top-level logical container.

Examples:

* PROD
* DEV
* HR

Contains:

* VRFs
* Networks
* Applications
* Policies

Think:

**Who owns this network?**

---

## 2. VRF (Virtual Routing and Forwarding)

Separate routing domain.

Best AWS mapping:

```text
VPC
```

Allows overlapping IP ranges without conflict.

Example:

```text
VRF: HR_VRF
```

---

## 3. Bridge Domain (BD)

Layer-2 network container.

Contains:

* Subnet
* Gateway

Example:

```text
BD: WEB_BD
```

---

## 4. Subnet

Defines IP range.

Example:

```text
10.10.10.0/24
Gateway: 10.10.10.1
```

---

## 5. App Profile

Groups application tiers.

Example:

```text
HR_APP
```

---

## 6. EPG (Endpoint Group)

Groups servers/endpoints with same policy.

Examples:

* WEB_EPG
* APP_EPG
* DB_EPG

---

## 7. Contract

Defines communication rules between EPGs.

Examples:

```text
WEB_EPG → APP_EPG (TCP 443)
APP_EPG → DB_EPG (TCP 3306)
```

Think:

**Firewall rules**

---

# HR Application Design

Architecture:

```text
Internet
↓
Web
↓
App
↓
Database
```

ACI Design:

```text
Tenant: PROD
│
├── VRF: PROD_VRF
│    ├── WEB_BD → 10.10.10.0/24
│    ├── APP_BD → 10.10.20.0/24
│    └── DB_BD  → 10.10.30.0/24
│
└── App Profile: HR_APP
     ├── WEB_EPG
     ├── APP_EPG
     └── DB_EPG

Contracts:
WEB_EPG → APP_EPG (443)
APP_EPG → DB_EPG (3306)
```

---

# Simple Logical Diagram

```text
              TENANT (PROD)
                    │
                    ▼
              VRF (PROD_VRF)
                    │
                    ▼
          Bridge Domain (WEB_BD)
                    │
                    ▼
          Subnet (10.10.10.0/24)
                    │
                    ▼
          App Profile (HR_APP)
                    │
                    ▼
              EPG (WEB_EPG)
                    │
                    ▼
         Contract (WEB_TO_APP)
```

---

# Development Plan

## Step 1

Create:

* Tenant
* VRF

---

## Step 2

Create:

* WEB_BD
* APP_BD
* DB_BD

Add subnets.

---

## Step 3

Create:

* HR_APP
* WEB_EPG
* APP_EPG
* DB_EPG

---

## Step 4

Create contracts:

* WEB_TO_APP
* APP_TO_DB

---

# NetasCode Flow

```text
YAML → Terraform → APIC → ACI Objects
```

Enhancement plan:

* tenants.yaml
* bridge_domains.yaml
* application_profiles.yaml
* contracts.yaml

Goal:

Build reusable and modular ACI configurations.
