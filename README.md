# docker & neo4j & bloom & no-root-user

## Step 1, get a Bloom licence
Put it in `./secrets/` and call it `bloom-server.license`.

## Step 2, get Docker
Assuming you have Docker...

Run:
```bash
$ ./test.sh
```

## Step 3, test Bloom
You should now have a Neo4j instance running 4.2-enterprise with Bloom 1.4.1. Hit http://localhost:7474/bloom and log in as `neo4j` with password `password`
