'use strict';

import Base from './base.js';
import moment from 'moment';

export default class extends Base {
  __before(){}

  async loginAction(){
    if(this.isAjax()){
      let { username, password } = this.param();
      let user = await this.model('user').where({
        mobile:username,password
      }).find();

      if(think.isEmpty(user)){
        return this.fail(600,'错误的用户名密码');
      }else{
        let { id, mobile } = user;
        await this.model('user').where({id}).update({login_time:moment().unix()});
        await this.session('user', {username, id, mobile});
        return this.success({redirect:'/admin'});
      }
    }else{
      return this.display();
    }
  }

  async regAction(){
    if(this.isAjax()){
      let { username, password } = this.param();
      let ret = await this.model('user').add({
        mobile:username,password
      });

      return this.success({redirect:'/auth/login'})
    }else{
      return this.display();
    }
  }

  async logoutAction(){
    await this.session();
    return this.redirect('/auth/login');
  }
}
