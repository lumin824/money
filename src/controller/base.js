'use strict';

export default class extends think.controller.base {

  async __before(){
    let user = await this.session('user');
    if(think.isEmpty(user)){
      return this.redirect('/auth/login');
    }
  }
}
