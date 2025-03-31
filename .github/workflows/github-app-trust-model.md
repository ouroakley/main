# GitHub App Trust Model

This document explains how GitHub's trust model works for GitHub Apps, particularly focusing on how apps can securely interact with repositories they're installed on.

## Overview

GitHub Apps use a three-tier trust model:
1. App Identity (Private Key)
2. Installation Access (Installation Tokens)
3. Repository Permissions (Scoped Access)

## Trust Layers

### 1. App Identity

The app's private key is its primary identity:
- Generated when the app is created
- Never shared with GitHub
- Used to sign JWTs that prove the app's identity
- Can be used to generate installation tokens for any installation of the app

```mermaid
graph TD
    A[App Private Key] -->|Signs| B[JWT]
    B -->|Proves| C[App Identity]
    C -->|Grants| D[Installation Access]

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#bbf,stroke:#333,stroke-width:2px
    style C fill:#bfb,stroke:#333,stroke-width:2px
```

### 2. Installation Access

Each installation of an app:
- Has its own unique installation ID
- Can generate installation-specific tokens
- Tokens are scoped to that installation
- Tokens expire after 1 hour

```mermaid
graph TD
    A[GitHub App] -->|Installed On| B[Main Repo]
    A -->|Installed On| C[Organiser Repo]

    B -->|Gets| D[Installation ID 1]
    C -->|Gets| E[Installation ID 2]

    D -->|Generates| F[Token for Main]
    E -->|Generates| G[Token for Organiser]

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#bbf,stroke:#333,stroke-width:2px
    style C fill:#bbf,stroke:#333,stroke-width:2px
    style F fill:#bfb,stroke:#333,stroke-width:2px
    style G fill:#bfb,stroke:#333,stroke-width:2px
```

### 3. Repository Permissions

The app's permissions are:
- Defined when the app is created
- Applied to all installations
- Can be modified by organisation admins
- Scoped to specific actions (e.g., deployments)

```mermaid
graph LR
    A[App Permissions] -->|Applied To| B[All Installations]
    B -->|Scoped To| C[Specific Actions]

    C -->|Example| D[Deployments]
    C -->|Example| E[Contents Read]
    C -->|Example| F[Workflows Read]

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#bbf,stroke:#333,stroke-width:2px
    style C fill:#bfb,stroke:#333,stroke-width:2px
```

### 3. Token Generation

The token generation process:
1. Workflow generates a JWT token using the private key
2. JWT token is used to request an installation token
3. GitHub verifies the JWT and issues an installation token
4. Installation token is used for API calls

```mermaid
sequenceDiagram
    participant W as Workflow
    participant A as GitHub App
    participant G as GitHub
    participant I as Installation
    participant R as Repository

    W->>A: Generate JWT with Private Key
    W->>G: Request Installation Token
    G->>G: Verify JWT
    G->>I: Issue Installation Token
    I->>R: Use Token for API Calls
```

## Trust Flow

```mermaid
sequenceDiagram
    participant O as Organisation
    participant A as GitHub App
    participant G as GitHub
    participant R as Repositories

    O->>A: Create App & Set Permissions
    O->>R: Install App
    R->>G: Get Installation IDs
    R->>A: Generate JWT in Workflow
    A->>G: Request Installation Token
    G->>G: Verify JWT
    G->>A: Issue Installation Token
    A->>R: Perform Actions
    G->>G: Verify Permissions
```

## Security Benefits

1. **Identity Verification**:
   - Private key proves app identity
   - JWTs are short-lived
   - Tokens are installation-specific

2. **Permission Control**:
   - Granular permission settings
   - Installation-specific access
   - Organisation-level management

3. **Access Revocation**:
   - Can revoke app access
   - Can revoke installation
   - Can modify permissions

## References

- [GitHub Apps Documentation](https://docs.github.com/en/developers/apps)
- [GitHub App Permissions](https://docs.github.com/en/developers/apps/managing-permissions-and-access-for-github-apps)
- [GitHub App Authentication](https://docs.github.com/en/developers/apps/building-github-apps/authenticating-with-github-apps)
