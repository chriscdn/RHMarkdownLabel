//
//  ViewController.m
//  RHMarkdownLabelExample
//
//  Created by Christopher Meyer on 23/02/16.
//  Copyright © 2016 Christopher Meyer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    NSString* path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"md"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];    
    
    [self.markdownLabel setMarkdown:content];
    
    [self.markdownLabel setDidSelectLinkWithURLBlock:^(RHMarkdownLabel *label, NSURL *url) {
        NSLog(@"URL tapped: @%@", url.absoluteString);
    }];
    
}

@end