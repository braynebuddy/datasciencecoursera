pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    ## NOTE: Do not round the result!
    
    # Create a data frame to hold the data we're going to read
    df <- data.frame(Date=NULL, sulfate=NULL, nitrate=NULL, ID=NULL)
    
    # Loop over all the monitor IDs requested
    for (monID in id) {
        # Build the csv filename for this monitor
        filename <- paste(directory, '/', sprintf("%03d",monID), '.csv', sep='')
        # Read the raw data and remove NAs for the pollutant we want
        newdf <- read.csv(filename)
        newdf <- newdf[!is.na(newdf[pollutant]),]
        # Add it to our list
        df <- rbind(df, newdf)
    }
    # Calculate the mean
    mean(df[[pollutant]])
}