#devtools::install_github("sciencificity/reclues")
library(reclues)
# murder on Jan 15 2018 in SQL City
library(tidyverse)
ourcrime <- crime_scene_report %>% filter(city=="SQL City", date == 20180115, type == "murder")
ourcrime$description
# our finding:
# "Security footage shows that there were 2 witnesses. The first witness lives at the last house on \"Northwestern Dr\". The second witness, named Annabel, lives somewhere on \"Franklin Ave\"."

person %>% data.frame() %>% head()
nw <- person %>% filter(address_street_name=="Northwestern Dr") %>% arrange(desc(address_number))
nw[1,] # Morty Shapiro person_id 14887

franklin <- person %>% filter(address_street_name =="Franklin Ave") %>% data.frame()
grep("Annabel", franklin$name) # index of all elements that contain "Annabel"
franklin[2,] # Annabel Miller, person_id 16371

interview %>% filter(person_id==14887) %>% data.frame()
# I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag.
# The membership number on the bag started with "48Z".
# Only gold members have those bags. The man got into a car with a plate that included "H42W".
interview %>% filter(person_id==16371) %>% data.frame()
# I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

drivers_license %>% head()
drivers_license %>% filter(str_detect(plate_number, "H42W"), gender=="male") %>% data.frame()
#id age height eye_color hair_color gender
#1 423327  30     70     brown      brown   male
#2 664760  21     71     black      black   male
#plate_number  car_make car_model
#1       0H42W2 Chevrolet  Spark LS
#2       4H42WR    Nissan    Altima



get_fit_now_member %>% head() %>% data.frame()
suspects <- get_fit_now_member %>% filter(membership_status=="gold",
                              membership_start_date <- 20180109, str_detect(id, "48Z")) %>% data.frame()

get_fit_now_check_in %>% head()
get_fit_now_check_in %>% filter(check_in_date == 20180109, str_detect(membership_id, "48Z")) %>% data.frame()

membership_id check_in_date check_in_time
1         48Z7A      20180109          1600
2         48Z55      20180109          1530
check_out_time
1           1730
2           1700

person %>% filter(license_id %in% c(423327, 664760)) %>% data.frame()


#####################
install.packages("tidyr")
library(tidyr)
library(help=tidyr)
data(french_fries, package="reshape2")
head(french_fries)
gather(french_fries, key=taste, value=score, potato:painty) -> fflong
pivot_longer(french_fries, names_to="taste", values_to = "score", potato:painty) ->ffpl




