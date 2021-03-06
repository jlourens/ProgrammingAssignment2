## makeCacheMatrix controls the storage of a cached matrix m.

## cacheSolve, through an if statement, checks if m!==NULL and calls m stored in environment of
## makeCacheMatrix. If m==NULL, then m is generated for the first time and then cached in
## makeCacheMatrix.

## makeCacheMatrix sets in place the control structures needed to cache a matrix m.

makeCacheMatrix <- function(x = matrix()) {     ##Converting x into an object which supports caching
        
        m <- NULL                               ##At the moment m == NULL and the so the cached matrix
                                                ##still has to be created and stored as m.
        set <- function(y) {                    
                x <<- y
                m <<- NULL
        }
        get <- function() return(x)             ##Fetches matrix x.
        
        setCache <- function(Cache) m <<- Cache ##Sets the the cached matrix m in the function environment 
                                                ##after it has been calculated the first time cacheSolve is called.
        
        getCache <- function() return(m)        ##Returns m that has been set for the function environment
        
        list(set = set, get = get               ##List of four functions enclosed in makeCacheMatrix environment.
                setCache = setCache,
                getCache = getCache)
}


## cacheSolve checks if m already exists and returns it if it is, otherwise generates m and caches it
## using makeCacheMatrix.

cacheSolve <- function(x = matrix(), ...) {
                m <- x$getCache()       ## Assigns m to a function that is a subset of the list of
                                        ## functions generated by makeCacheVector.
                
                if(!is.null(m)) {       ## Checks if m is non-empty i.e. matrix already cached to m.
                        message("getting cached data")
                        return(m)       ##Returns m if it was already cached in makeCacheMatrix.
                }
                data <- x$get()         ## If m ==NULL, then x$get() from makeCacheMatrix is assgined to
                                        ## new object called data.
                
                m <- solve(data, ...)   ## data is passed to solve() which produces the inverse matrix, m.
                
                x$setCache(m)           ## m is cached in makeCacheMatrix ready to be called in the
                                        ## future.
                
                m                       ## m, inverse of x, is returned.
        }
