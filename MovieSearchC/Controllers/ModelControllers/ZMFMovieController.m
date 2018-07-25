//
//  ZMFMovieController.m
//  MovieSearchC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import "ZMFMovieController.h"
#import "ZMFMovie.h"
#import "UIKit/UIKit.h"

@implementation ZMFMovieController

// MARK: - Singleton
+ (ZMFMovieController *)sharedController
{
    static ZMFMovieController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [ZMFMovieController new];
    });
    return sharedController;
}

// MARK: - Properties
- (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://api.themoviedb.org/3/search/movie"];
}

- (NSURL *)imageURL
{
    return [NSURL URLWithString:@"http://image.tmdb.org/t/p/w500/" ];
}

// MARK: - Methods
- (void)retrieveMovies:(NSString *)searchText completion:(void (^)(NSArray<ZMFMovie *> *movies))completion
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:[self baseURL] resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiKeyQuery = [NSURLQueryItem queryItemWithName:@"api_key" value:@"c5c1f4910df19b60d4b5657cf2225704"];
    NSURLQueryItem *languageQuery = [NSURLQueryItem queryItemWithName:@"language" value:@"en-US"];
    NSURLQueryItem *movieQuery = [NSURLQueryItem queryItemWithName:@"query" value:searchText];
    urlComponents.queryItems = @[apiKeyQuery, languageQuery, movieQuery];
    
    NSURL *searchURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error occurred: no data returned from task.");
            completion;
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *resultsArray = jsonDictionary[@"results"];
        NSMutableArray *moviesArray = [NSMutableArray new];
        for (NSDictionary *movieDictionary in resultsArray) {
            ZMFMovie *movie = [[ZMFMovie alloc] initWithDictionary:movieDictionary];
            [moviesArray addObject:movie];
        }
        
        completion(moviesArray);
        
    }] resume];
    
    
}

- (void)retrieveImageForMovie:(ZMFMovie *)movie completion:(void (^)(UIImage *image))completion
{
    NSURL *imageURL = [[self imageURL] URLByAppendingPathComponent:movie.imageURLExtension];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error occurred: no data returned from task.");
            completion;
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }] resume];
}

@end
