library(Lahman)
head(HallOfFame)
head(Master)

hof <- HallOfFame %>% left_join(Master, by="playerID")

alive2018 <- hof %>% filter(is.na(deathDate))
alive2018 %>% filter(nameLast=="Sosa")
############

devtools::install_github("sciencificity/reclues")
library(reclues)
murder <- crime_scene_report %>% filter(
  date == 20180115,
  city == "SQL City",
  type == "murder"
)
murder$description

witness1 <- person %>% filter(
  address_street_name=="Northwestern Dr",
  address_number==max(address_number))
witness2 <- person %>% filter(str_detect(name, "Annabel "))

interviews <- interview %>% filter(person_id %in% c(witness1$id, witness2$id))
interviews$transcript

suspects1 <- get_fit_now_member %>% filter(
  membership_status == "gold",
  str_detect(id, "48Z")
    )

suspects1 %>%
  left_join(person, by=c("person_id"="id")) %>%
  left_join(drivers_license, by=c("license_id"="id")) %>%
  filter(str_detect(plate_number, "H42W"))

suspects2 <- get_fit_now_check_in %>% filter(
  check_in_date == 20180109
) %>% left_join(get_fit_now_member, by=c("membership_id"="id")) %>%
  filter(check_out_time > 1600)


fb <- suspects2 %>% left_join(facebook_event_checkin, by=c("person_id")) %>%
  filter(date =="20180115")
fb$event_name

