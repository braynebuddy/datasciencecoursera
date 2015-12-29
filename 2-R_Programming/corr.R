corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!

    # Create a numeric vector to hold the results
    cors <- c()
    
    # Loop over all the monitor IDs
    for (monID in 1:332) {
        # Build the csv filename for this monitor
        filename <- paste(directory, '/', sprintf("%03d",monID), '.csv', sep='')
        # Read the raw data and remove NAs for incomplete cases
        df <- read.csv(filename)
        df <- df[complete.cases(df),]
        
        if(nrow(df)>=threshold) {
            cors = c(cors, cor(df$nitrate, df$sulfate))
        }
    }
    # Return the numeric vector
    cors
    
}