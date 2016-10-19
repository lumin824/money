'use strict';

import Base from './base.js';
import request from 'request';
import _ from 'lodash';
import moment from 'moment';

export default class extends Base {

  async __before(){
    let user = await this.session('user');
    let openid = await this.session('wechat_openid');
    let { action, host, hostname } = this.http;
    console.log([host,hostname]);
    if(!user){
      if(openid){
        if(action != 'reg'){
          return this.redirect('/wechat/reg');
        }
      }
      else{
        if(action != 'login'){
          let { appid } = this.config('web.wechat');
          let redirect_uri = 'http://81dai.ngsyun.com/wechat/login';
          let response_type = 'code';
          let scope = 'snsapi_base';
          let state = 'STATE';
          return this.redirect(`https://open.weixin.qq.com/connect/oauth2/authorize?appid=${appid}&redirect_uri=${redirect_uri}&response_type=${response_type}&scope=${scope}&state=${state}#wechat_redirect`)
        }
      }
    }
  }

  async indexAction(){
    let { mobile } = await this.session('user');

    let list = await this.model('loan').where({mobile}).select();
    list = _.map(list, o=>({
      ...o,
      start_time: moment.unix(o.start_time).format('YYYY-MM-DD')
    }));
    this.assign({mobile,list});
    return this.display();
  }

  async loginAction(){
    let { code } = this.param();
    let { appid, secret } = this.config('web.wechat');
    let grant_type = 'authorization_code';
    let openid = await new Promise((reslove, reject)=>{
      request(`https://api.weixin.qq.com/sns/oauth2/access_token?appid=${appid}&secret=${secret}&code=${code}&grant_type=${grant_type}`, (error, response, body)=>{
        if(error) reject(error);
        else{
          reslove(JSON.parse(body).openid);
        }
      });
    })
    if(openid){
      let user = await this.model('user').where({wechat_openid:openid}).find();
      if(think.isEmpty(user)){
        await this.session('wechat_openid', openid);
        return this.redirect('/wechat/reg');
      }else{
        await this.session('user',{
          id:user.id,
          mobile:user.mobile
        });
        return this.redirect('/wechat');
      }
    }else{
      return this.display();
    }

  }

  async regAction(){
    if(this.isAjax()){
      let { mobile, captcha } = this.param();
      let wechat_openid = await this.session('wechat_openid');

      let user = await this.model('user').where({mobile}).find();
      if(think.isEmpty(user)){
        let id = await this.model('user').add({
          mobile, wechat_openid, password:wechat_openid
        });
        user = await this.model('user').where({id}).find();
      }else{
        await this.model('user').where({id:user.id}).update({
          wechat_openid
        });
      }
      await this.session('user', {
        id:user.id,
        mobile:user.mobile
      });
      return this.success({redirect:'/wechat'});
    }else{
      return this.display();
    }

  }

  homeAction(){
    return this.display();
  }
}
