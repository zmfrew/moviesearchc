//
//  ZMFMovieController.h
//  MovieSearchC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZMFMovie;

@interface ZMFMovieController : NSObject

NS_ASSUME_NONNULL_BEGIN

+ (instancetype)sharedController;

- (void)retrieveMovies:(NSString *)searchText completion:(void(^) (NSArray<ZMFMovie *> *movies))completion;

- (void)retrieveImageForMovie:(ZMFMovie *)movie completion:(void(^) (UIImage *image))completion;

NS_ASSUME_NONNULL_END

@end
