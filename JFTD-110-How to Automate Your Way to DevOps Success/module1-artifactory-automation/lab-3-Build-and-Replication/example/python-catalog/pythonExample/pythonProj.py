#!/usr/bin/python
import numpy as np
import yaml

# Function definition is here
def printme( str ):
    # This prints a passed string into this function
    print (str)
    rng = np.random.default_rng()
    samples = rng.normal(size=2500)
    print (samples)
    with open('config.yml', 'r') as file:
        prime_service = yaml.full_load(file)
    print(prime_service['prime_numbers'][0])
    return;

# Now you can call printme function
printme("Hello from JFROG");
