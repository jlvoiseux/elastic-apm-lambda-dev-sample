import json
import os
import time
import sys
sys.path.insert(0, 'dependencies')

import requests
import elasticapm
from elasticapm import capture_serverless

@capture_serverless()
def lambda_handler(event, context):
    primesArr = primes(1000)
    return {
        "statusCode": 200,
        "body": json.dumps({
        "message": primesArr,
    }),
}

# Compute sequence of prime numbers
def primes(n):
    out = []
    sieve = [True] * (n+1)
    for p in range(2, n+1):
      if (sieve[p]):
          out.append(p)
          for i in range(p, n+1, p):
              sieve[i] = False
    return out
