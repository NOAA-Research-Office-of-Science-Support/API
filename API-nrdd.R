# Libraries ---------------------------------------------------------------

library(httr)
library(jsonlite)
library(keyring)

# ----------------------------------------------------------
# submit POST request and supply your NRDD username, password, and API KEY
# for authorized log in 
request <- POST (
  url = "https://researchprojects.noaa.gov/DesktopModules/NRDD/API/Login/Login",
  body = list(
    username = "nrdd.user",
    password = key_get(service = "password", keyring = "nrdd_login")
            ),
  add_headers(
    "Accept" = "application/json;charset=utf-8",
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36",
    "NRDD_LO_API_KEY" = key_get(service = "apikey", keyring = "nrdd_login")),
  content_type("application/json"),
  encode = "json"
)

keyring_lock("nrdd_login")

stop_for_status(request)
content(request)

# NRDD BASE URL endpoint: "https://researchprojects.noaa.gov/DesktopModules/NRDD/API/QueryBuilder"
# the next line of code will GET the Project_Information Table from the nrdd
response <- GET(url = "https://researchprojects.noaa.gov/DesktopModules/NRDD/API/QueryBuilder/Get/vwReport_Project_Information", 
            content_type("application/json"),
            add_headers(
              "Accept" = "application/json;charset=utf-8",
              "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
            ))

# read the content of the response and reformat into df
json_data <- content(response) # parse data into JSON
df_data <- fromJSON(json_data) # parse JSON into list
df_data <- as.data.frame(df_data[[1]]) # parse list into dataframe format

# --------------------------------------------------------------------
# Another example to GET the count of data in the database
response <- GET(url = "https://researchprojects.noaa.gov/DesktopModules/NRDD/API/QueryBuilder/Count/vwReport_Project_Information",
                content_type("application/json"),
                add_headers(
                  "Accept" = "application/json;charset=utf-8",
                  "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"
                ))
