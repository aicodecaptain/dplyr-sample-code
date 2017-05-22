library(dplyr)

current_markets_path <- "Data/Data/Current routes.csv"
data <- read.csv(file = current_markets_path)

#Clean the Data
demogfx <- data %>% 
  dplyr::select(Income, 
                Age,
                Home.Value, 
                Percent.Hispanic,
                Percent.Household.With.Children,
                Percent.Owner.Occupied,
                Market,
                SFDU,
                MFDU,
                Businesses,
                ZIP,
                Market,
                Excluded.Route) %>%
  mutate(., SFDU = as.numeric(SFDU)) %>%
  mutate(., MFDU = as.numeric(MFDU)) %>%
  mutate(., Businesses = as.numeric(Businesses)) %>%
  mutate(., Income = as.numeric(gsub(",", "", substring(Income, 2),))) %>%
  mutate(., Home.Value = as.numeric(gsub(",", "", substring(Home.Value, 2),))) %>%
  mutate(., Percent.Hispanic = as.numeric(gsub(",", "", substr(Percent.Hispanic, 1, nchar(as.character(Percent.Hispanic)) - 1),))) %>%
  mutate(., Percent.Household.With.Children = as.numeric(gsub(",", "", substr(Percent.Household.With.Children, 1, nchar(as.character(Percent.Household.With.Children)) - 1),))) %>%
  mutate(., Percent.Owner.Occupied = as.numeric(gsub(",", "", substr(Percent.Owner.Occupied, 1, nchar(as.character(Percent.Owner.Occupied)) - 1),))) %>%
  mutate(., p_SFDU = SFDU / (SFDU + MFDU)) %>%
  mutate(., BPDU = Businesses / (SFDU + MFDU)) %>% 
  filter(is.na(Excluded.Route) == T) %>% filter(nchar(as.character(Market)) == 3)
