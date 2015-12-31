rankhospital <- function(state, outcome, num = "best") {
    outcomes <- c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
    h_name <- 2
    h_state <- 7
    
    ## Read outcome data
    setwd("~/Documents/Data Analytics/datasciencecoursera/2-R_Programming/ProgAssignment3")
    rawdata <- read.csv("outcome-of-care-measures.csv",  na.strings="Not Available", stringsAsFactors=FALSE)
    
    ## Check that state and outcome are valid
    state_ok <- FALSE
    for (s in rawdata[,h_state]) {
        if (s == state) state_ok <- TRUE
    }
    if (!state_ok) stop("invalid state")
    
    outcome_ok <- FALSE
    for (o in names(outcomes)) {
        if (o == outcome) outcome_ok <- TRUE
    }
    if (!outcome_ok) stop("invalid outcome")
    
    # Extract the data for the requested state
    statedata <- split(rawdata, rawdata$State)[[state]]
    
    # Extract the three columns we need
    mydata <- statedata[,c(h_name,h_state,outcomes[outcome])]
    names(mydata) <- c("hospital", "state", "outcome")
    
    # Only keep complete cases
    mydata <- mydata[complete.cases(mydata),]
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    mydata <- mydata[order(mydata$outcome, mydata$hospital),]

    result <- NA
    if (num == "best") result <- mydata$hospital[1]
    else if (num == "worst") result <- mydata$hospital[nrow(mydata)]
    else if (is.numeric(num)) {
        n <- as.numeric(num)
        if (n > 0 & n < nrow(mydata)) result <- mydata$hospital[n]
    }
    result
}