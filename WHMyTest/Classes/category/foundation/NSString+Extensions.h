//
//  NSString+Extensions.h
//  YHB_Prj
//
//  Created by 王华 on 16/7/11.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

- (NSString *)md5;

/**
 *  判断是否是反贝的链接
 */
- (BOOL)wh_validateFanb8Url;
/**
 *  字符串是否为空字符串
 */
- (BOOL)wh_isEmpty;
/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)wh_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat)wh_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width space:(CGFloat)space;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)wh_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)wh_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)wh_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)wh_reverseString:(NSString *)strSrc;

#pragma mark - dlemoji

/**
 *  @brief  是否包含emoji
 *
 *  @return 是否包含emoji
 */
- (BOOL)wh_isIncludingEmoji;

/**
 *  @brief  删除掉包含的emoji
 *
 *  @return 清除后的string
 */
- (instancetype)wh_removedEmojiString;

#pragma mark - trim
/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)wh_stringByStrippingHTML;
/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)wh_stringByRemovingScriptsAndStrippingHTML;
/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)wh_trimmingWhitespace;
/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)wh_trimmingWhitespaceAndNewlines;


- (NSString *)countNumAndChangeformat:(id)number;
#pragma mark - emoji

/**
 Returns a NSString in which any occurrences that match the cheat codes
 from Emoji Cheat Sheet <http://www.emoji-cheat-sheet.com> are replaced by the
 corresponding unicode characters.
 
 Example:
 "This is a smiley face :smiley:"
 
 Will be replaced with:
 "This is a smiley face \U0001F604"
 */
- (NSString *)wh_stringByReplacingEmojiCheatCodesWithUnicode;

/**
 Returns a NSString in which any occurrences that match the unicode characters
 of the emoji emoticons are replaced by the corresponding cheat codes from
 Emoji Cheat Sheet <http://www.emoji-cheat-sheet.com>.
 
 Example:
 "This is a smiley face \U0001F604"
 
 Will be replaced with:
 "This is a smiley face :smiley:"
 */
- (NSString *)wh_stringByReplacingEmojiUnicodeWithCheatCodes;

#pragma mark - jsonToDictionary
/**
 *  @brief  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
-(NSDictionary *)wh_dictionaryValue;


#pragma mark - urlEncode
/**
 *  @brief  urlEncode
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)wh_urlEncode;
/**
 *  @brief  urlEncode
 *
 *  @param encoding encoding模式
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)wh_urlEncodeUsingEncoding:(NSStringEncoding)encoding;
/**
 *  @brief  urlDecode
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)wh_urlDecode;
/**
 *  @brief  urlDecode
 *
 *  @param encoding encoding模式
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)wh_urlDecodeUsingEncoding:(NSStringEncoding)encoding;

/**
 *  @brief  url query转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)wh_dictionaryFromURLParameters;

#pragma mark - contains
/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)wh_isContainChinese;
/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)wh_isContainBlank;

/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)wh_makeUnicodeToString;

- (BOOL)wh_containsCharacterSet:(NSCharacterSet *)set;
/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含;
 */
- (BOOL)wh_containsaString:(NSString *)string;
/**
 *  @brief 获取字符数量
 */
- (int)wh_wordsCount;

#pragma mark - regex
/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)wh_isMobileNumberClassification;


/**
 *  邮箱的有效性
 */
- (BOOL)wh_isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)wh_simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)wh_accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)wh_isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)wh_bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)wh_isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)wh_isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)wh_isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)wh_isValidChinese;

/**
 *  邮政编码
 */
- (BOOL)wh_isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)wh_isValidTaxNo;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)wh_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)wh_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
                 containDigtal:(BOOL)containDigtal
                 containLetter:(BOOL)containLetter
         containOtherCharacter:(NSString *)containOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
/**
 *  替换字符串字符
 *
 */
-(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght;
/**
 *  手机号有效性
 */
- (BOOL)wh_isMobileNumber;
/**
 *  count为数字
 */
- (BOOL)wh_isNumberOfCount:(NSInteger)count;
/**
 *  count为数字
 */
- (BOOL)wh_isNumbers;
/**
 *  有效密码/有效用户名,6-16位数字，字母，下划线至少两种组合
 */
- (BOOL)wh_isPasswordNumber;
/**
 *  有效账号
 */
- (BOOL)wh_isValubleAccount;
/**
 *  有效支付密码
 */
- (BOOL)wh_isValublePayPassworld;

/**
 *  财神登录密码规则
 *
 */
- (BOOL)wh_isValueCsyyLoginPassword;



/**
 将诸如“100”转变为“000000010000”(一共12位，最后两位表示小数点后两位)
 */
+ (NSString *)dealTranAmtWithString:(NSString *)tranString;

/**
 * 增加千分位
 */
+ (NSString *)increaseThousandthPlace:(NSString *)text;



@end
