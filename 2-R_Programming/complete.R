complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    # Create a data frame to hold the data we're going to read
    df <- data.frame(id=NULL, nobs=NULL)
    
    # Loop over all the monitor IDs requested
    for (monID in id) {
        # Build the csv filename for this monitor
        filename <- paste(directory, '/', sprintf("%03d",monID), '.csv', sep='')
        # Read the raw data and remove NAs for the pollutant we want
        newdf <- read.csv(filename)
        newdf <- newdf[complete.cases(newdf),]
        newRow <- data.frame(id=monID, nobs=nrow(newdf))
        # Add it to our list
        df <- rbind(df, newRow)
    }
    # Return the data frame
    df
    
}