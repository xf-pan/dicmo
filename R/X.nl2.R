#' @title function to estimate 2-level nested logit model
#'
#' @author X.PAN
#'
#' @description This function could estimate 2-level nested logit model along
#'     with converting the data from a wide format to a long format and code the
#'     categorical attributesallow allow. In detail, it allows to estimate
#'     interaction effects between attributes and alternative-specific
#'     parameters.
#'
#' @export X.nl2
#'
#' @importFrom rlang :=
#'
#' @param data A tibble, input data, wide format.
#'
#' @param choice A character, name of column indicating individuals' choice.
#'
#' @param alts A vector of characters, names of all alternatives, including
#'     the none-option if any.
#'
#' @param attrs A list contains three slices, whose elements have to be non-
#'     negative integers. The first one is a tibble, named "attrs_alts",
#'     indicating the alternative-specific attributes (excluding ASCs); the
#'     second one, named "asc", is a vector indicating the ASCs, and the third
#'     one, named "context", is a tibble indicating the context variables
#'     (includig individuals' socio-demographics). The column names in all
#'     tibbles represent the name of attributes, or context variables. All have
#'     same numbers of rows (elements) with the length of argument "alts". The
#'     element in tibbles/vector indicates if the attribute, constant or
#'     context variable is alternative-specific: "0" means the attribute,
#'     constaant or context variable is not available for the alternative
#'     (based on the sequence of alternative in the argument "alts"); except
#'     "0", if some elements in one column have a same value, then the
#'     corresponding alternatives have generic parameter in terms of this
#'     attribute, constant or context variable.
#'
#' @param nest A list, indicating how many nests at all and which alternatives
#'     are in the same nest.
#'
#' @param nest_uni A logical, indicating if the inclusive values for the nests
#'     are the same or not. Default = TRUE, means the inclusive values are the
#'     same.
#'
#' @param attr_coding A vector of character, names of categorical attributes.
#'     Default = NULL, which means all attributes are continuous.
#'
#' @param attr_level A list of vector of character, representing the levels of
#'     all categorical attributes. The first element of a vector is set as base
#'     level, others are set as 1, 2, 3...in sequence. This argument is only
#'     relevent when argument "attr_coding" is not NULL. Default = NULL.
#'
#' @param interact A vector of character, name of attributes' interaction,
#'     connected by "*". Default = NULL.
#'
#' @param avi A character, name of column indicating if an alternative is
#'     available to individuals. Default = NULL, indicating all alternatives are
#'     available to all respondents. Each alternative should have such a column,
#'     for example, avi = "available" then the column's name for an alternative
#'     (e.g. the alternative's name is "car") should be "available:car" or
#'     "car:avilable". If this parameter is NULL, then those columns are not
#'     necessary. If this parameter is not NULL, then in such as column, the
#'     element should be 0 if the alternative is not available otherwise 1.
#'
#' @param method A character, passed to the function maxLik() in "maxLik"
#'     package. It indicates the method used in maximum likelihood estimation.
#'     Default = "BFGS".
#'
#' @param estimator A argument in the function maxLik() from "maxLik"
#'     package. Here this argument could only be either TRUE or "BHHH"/"bhhh".
#'     Default = TRUE.
#'
#' @param param_fixed A vector of characters, passed to the function maxLik() in
#'     "maxLik" package. It indicates which parameters are fixed. Default = NULL.
#'
#' @param param_start A vector of numbers, passed to the function maxLik() in
#'     "maxLik" package. It indicages the initial values of parameters.
#'     Default = NULL.
#'

X.nl2 <- function(data, choice, alts, attrs, nest, nest_uni =TRUE,
                  attr_coding = NULL, attr_level = NULL,
                  interact = NULL, avi = NULL,
                  method = "BFGS", estimator = TRUE,
                  param_fixed = NULL, param_start = NULL){

  # data preparation --------------------------------------------------------

  # data preparation and return the data set can be used and the utility formula
  process_data <- L.data(data = data, choice = choice, alts = alts,
                         attrs = attrs, attr_coding = attr_coding,
                         attr_level = attr_level, interact = interact,
                         avi = avi)

  # model estimation
  E.nl2(process_data = process_data,
        param_start = param_start, alts = alts, avi = avi,
        nest = nest, choice = choice, nest_uni = nest_uni,
        method = method, param_fixed = param_fixed, estimator = estimator)

}
