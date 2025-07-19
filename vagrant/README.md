# Foreman - HDM - Demo Setup

## Installation

Run `vagrant up`

## Configuration

Log in into `https://openvox.hdm.workshop.betadots.training`

Credentials:

Username: `admin`
Password: `betadots_training_2025`

Add HDM Smart Proxy to both hosts (openvox and apache)

## Demo

Open `http://openvox.hdm.workshop.betadots.training:3000`

No authentication required.

Run the following demos:

### Read and anaylze data

1. Show environments
2. Show node List
3. Select node openvox
4. Show typo chrony::servers and chrony::server
5. Select key `lookup_options`
6. Select `common.yaml` layer
7. Select key `classes`  show that there are two layers with data
8. Open node and common hierarchies
9. Click on `Show lookup result`
10. Select key `string` explain the lock symbol
11. Open `common.yaml`
12. Click `decrypt` explain that this is optional and must be activated explizitly
13. Select key `hdm::version`
14. Show Module Layer hierarchies

### Diff between Env Data

1. Select env `feat_23498`
2. Show node list and explain why list is empty
3. Klick on `Only from ...` switch
4. Open node List, select openvox
5. Select key `hdm::version`
6. Open node hierarchy and explain the diff tab
7. Select diff
8. (BUG) Click on `Show Result` (see Git Issue)

### Search for Keys

1. Select env `production`
2. Search for key `crony::servers`
3. Open hierarchies
4. Open Data

