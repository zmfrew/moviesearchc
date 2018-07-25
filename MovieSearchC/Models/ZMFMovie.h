//
//  ZMFMovie.h
//  MovieSearchC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMFMovie : NSObject

NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, copy, readonly) NSString* title;
@property (nonatomic, readonly) NSInteger rating;
@property (nonatomic, copy, readonly) NSString* movieDescription;
@property (nonatomic, copy, readonly) NSString* imageURLExtension;

- (instancetype)initWithTitle:(NSString *)title
                       rating:(NSInteger)rating
             movieDescription:(NSString *)movieDescription
            imageURLExtension:(NSString *)imageURLExtension;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

NS_ASSUME_NONNULL_END

@end
