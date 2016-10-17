'use strict';

import Base from './base.js';

export default class extends Base {

  __before(){}

  indexAction(){
    return this.redirect('https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx2c7dfeded02e0cb1&redirect_uri=http://www.isotaf.com/wechat/a&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect')
  }

  loginAction(){
    return this.display();
  }
}
