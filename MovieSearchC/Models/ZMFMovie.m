//
//  ZMFMovie.m
//  MovieSearchC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import "ZMFMovie.h"

@implementation ZMFMovie

// MARK: - Properties


// MARK: - Initializers
- (instancetype)initWithTitle:(NSString *)title rating:(NSInteger)rating movieDescription:(NSString *)movieDescription imageURLExtension:(NSString *)imageURLExtension
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _rating = rating;
        _movieDescription = [movieDescription copy];
        _imageURLExtension = [imageURLExtension copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[[ZMFMovie titleKey]];
    NSInteger *rating = [dictionary[[ZMFMovie ratingKey]] integerValue];
    NSString *movieDescription = dictionary[[ZMFMovie movieDescriptionKey]];
    NSString *imageURLExtension = dictionary[[ZMFMovie imageURLExtensionKey]];
    
    return [self initWithTitle:title rating:rating movieDescription:movieDescription imageURLExtension:imageURLExtension];
}


// MARK: - Keys
+ (NSString *)titleKey
{
    return @"original_title";
}

+ (NSString *)ratingKey
{
    return @"vote_average";
}

+ (NSString *)movieDescriptionKey
{
    return @"overview";
}

+ (NSString *)imageURLExtensionKey
{
    return @"poster_path";
}


@end
