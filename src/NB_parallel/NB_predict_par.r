NB_predict_par <- function(newdata, theta, prior.positive = 10**(-4))
{
#================================================================================
#Function: NB_predict_par
#
#--------------------------------------------------------------------------------
#Description:
#    Predict the outcome value of each peptide in newdata. This is a parallel 
#    version of NB_predict. When newdata is large(e.g, more than  peptides), 
#    this function should be preferred.
#
#--------------------------------------------------------------------------------
#Input arguments:
#    newdata
#            A data frame whose rows correspond to peptides and columns to 
#            features. THERE SHALL BE NO OUTCOME VALUES.
#    theta
#            Likelihood parameters. A list returned by the function getTheta.
#    prior.positive
#            Prior distribution Pr(Y=1) where Y is the outcome value. The default 
#            10^-4. 
#
#--------------------------------------------------------------------------------
#Return objects:
#    predict
#            A vector of posterior outcomes of each peptide.  
#--------------------------------------------------------------------------------
    theta_0 <- theta$theta_0
    theta_1 <- theta$theta_1
    nData <- dim(newdata)[1]
    #K: number of features
    K <- dim(newdata)[2] 
    predict <- foreach(n=1:nData, .combine = append) %dopar% {
        feature <- as.numeric(newdata[n,])
        likelihood_1 <- 1
        likelihood_0 <- 1
        for(i in 1:K) {
            if(!is.na(feature[i])){
                likelihood_1 <- theta_1[feature[i],i]*likelihood_1
                likelihood_0 <- theta_0[feature[i],i]*likelihood_0
            }
        }
        likelihood_1*prior.positive/(likelihood_0*(1-prior.positive)
            + likelihood_1*prior.positive)
    }
    return(predict)
}
