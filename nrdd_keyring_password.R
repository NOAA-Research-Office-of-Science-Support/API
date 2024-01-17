# R version 4.3.1
# Date: 01/17/2024
# Contact: nrdd.admin@noaa.gov or ishrat.jabin@noaa.gov for questions/concerns

# Libraries ---------------------------------------------------------------

library(keyring)

# -------------------------------------------------------------------------
# create general keyring password -- a POPUP will ask for keyring password
keyring_create("nrdd_login")

# Store NRDD password (secret) -- a POPUP will ask for NRDD password
key_set(service = "password", keyring = "nrdd_login")

# Store API KEY (secret) -- a POPUP will ask for KEY
key_set(service = "apikey", keyring = "nrdd_login")

# Always lock the keyring after key_set or key_get for security
keyring_lock("nrdd_login")

# test to see that password and key can be accessed
# avoid storing or printing the get values (i.e. password or token)
key_get(service = "password", keyring = "nrdd_login")
key_get(service = "apikey", keyring = "nrdd_login")

keyring_lock("nrdd_login")

# -------------if you want to DELETE a keyring ----------------------------

keyring_delete(keyring = "nrdd_login")
