//
//  QRCodeTableViewCelTableViewCell.m
//  iOptic
//
//  Created by Santhosh on 15/08/17.
//  Copyright © 2017 mycompany. All rights reserved.
//

#import "QRCodeTableViewCelTableViewCell.h"
#import "UIImage+MDQRCode.h"

@interface QRCodeTableViewCelTableViewCell()
@property(nonatomic) NSString *qrJsonString;
@end

@implementation QRCodeTableViewCelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateQR:(NSString*)json
{
    self.qrJsonString = json;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutSubviews];
    float width = self.qrCodeImageView.bounds.size.width;
    self.qrCodeImageView.image = [UIImage mdQRCodeForString:self.qrJsonString size:width fillColor:[UIColor blackColor]];
}


@end
