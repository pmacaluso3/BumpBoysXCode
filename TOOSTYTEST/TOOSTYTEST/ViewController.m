//
//  ViewController.m
//  TOOSTYTEST
//
//  Created by Apprentice on 7/17/15.
//  Copyright (c) 2015 Bump Boys!, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"Test");
    // Do any additional setup after loading the view, typically from a nib.
    NSString *location = @"Chicago";
    NSString *prefix = @"https://evening-eyrie-3304.herokuapp.com?location=";
    NSString *queryString = [prefix stringByAppendingString:location];
    [NSURLConnection sendAsynchronousRequest:
      [NSURLRequest requestWithURL:
       [NSURL URLWithString:queryString]]
        queue:[NSOperationQueue mainQueue]
        completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                            id foo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                NSLog(@"%@", foo);
                                [self addToTextField:(NSString*)foo[@"msg"]];
                            }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can@ be recreated.
}


- (IBAction)buttonTouch:(id)sender {
//    NSLog(@"fomt");
//    [self.myTextField setText:(@"alright")];
//    [self addToTextField:(NSString*)@"Test"];
}

// Void means that it doesnt return anything.
-(void)addToTextField:(NSString*)url{
    [self.myTextField setText:url];
}



@end



//- (IBAction)buttonTouch:(id)sender {
//    [self.myTextField setText:(@"%@", @"Test")];
//}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self.myTextField setText:@"Hi Bo"];
//
////    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/gists.json"]]
////                                       queue:[NSOperationQueue mainQueue]
////                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
////
////                               id foo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
////                               NSLog(@"%@", foo);
////     }];
//
//}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

// IBAction are essentially event handlers.
//- (IBAction)editMethod:(UITextField *)sender {
//    [self.myLabel setText:[sender text]];
//}
//
//- (IBAction)handleTap:(id)sender {
//    [self.myTextField endEditing:YES];
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [self.myLabel setText:[textField text]];
//
//    return YES;

//}
//- (IBAction)buttonOne:(id)sender {
//    NSLog(@"%@", @"Trying");
//}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    [self.myLabel setText:[textField text]];
//    return YES;
//}
