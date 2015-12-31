rankall <- function(outcome, num = "best") {
    outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    h_name <- 2
    h_state <- 7
    
    ## Read outcome data
    setwd("~/Documents/Data Analytics/datasciencecoursera/2-R_Programming/ProgAssignment3")
    rawdata <- read.csv("outcome-of-care-measures.csv",  na.strings="Not Available", stringsAsFactors=FALSE)
    
    ## Check that outcome is valid
    outcome_ok <- FALSE
    for (o in names(outcomes)) {
        if (o == outcome) outcome_ok <- TRUE
    }
    if (!outcome_ok) stop("invalid outcome")

    # Extract the three columns we need
    mydata <- rawdata[,c(h_name,h_state,outcomes[outcome])]
    names(mydata) <- c("hospital", "state", "outcome")
    
    # Only keep complete cases
    mydata <- mydata[complete.cases(mydata),]
    
    # Sort by state, outcome, then hospital name
    mydata <- mydata[order(mydata$state, mydata$outcome, mydata$hospital),]
    splitdata <- split(mydata, mydata$state)

    # Get a hospital name from a state data frame
    hospitalName <- function(df, n="best") {
        r <- -1
        if (n == "best") r <- 1
        else if (n == "worst") r <- nrow(df)
        else r <- n
        df$hospital[r]
    }
    ## For each state, find the hospital of the given rank
    hospitals <- unlist(lapply(splitdata,hospitalName, num))
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    data.frame(hospital = hospitals, state = names(hospitals), row.names = names(hospitals))
}