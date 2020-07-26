/**
 * 회원가입시 각 항목에 대한 입력 유효성 판단
 */
 
 var space = /\s/g;
 var title='';
 var join = {
 	common:{
 		empty:{code:'invalid', desc:title+'입력하세요.' },
 		space: {code:'invalid', desc:'공백없이 입력하세요.' },
 		
 	},
 	id:{
 		valid: { code:'valid', desc:'아이디 중복확인버튼을 클릭해주세요.' },
 		invalid: { code:'invalid', desc:'아이디는 이메일 주소로 입력해주세요.' },
 		usable: { code: 'valid', desc:'사용가능한 아이디입니다. 해당 이메일로 전송된 인증번호를 입력해주세요.'},
 		unusable: {code: 'invalid', desc:'이미 사용중인 아이디입니다.'},
 	},
 	id_usable: function(data){
 		if( data ) return this.id.usable;
 		else return this.id.unusable;
 	},
 	id_status: function(id){
 		var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
 		title = $('[name=id]').attr('title');
 		if( id=='' ) return this.common.empty;
 		else if(id.match(space) ) return this.common.space;
 		else if( !reg.test(id) ) return this.id.invalid;
 		else return this.id.valid;
 	},
 	pw:{
 		valid: { code:'valid',desc:'사용가능한 비밀번호입니다.'},
 		invalid: { code:'invalid',desc:'비밀번호는 영문 대/소문자, 숫자, 특수문자만 입력하세요.'},
 		lack:{ code:'invalid', desc:'비밀번호는 영문 대/소문자, 숫자, 특수문자를 모두 포함해야 합니다.'},
 		equal: { code:'valid', desc:'비밀번호가 일치합니다.'},
 		notEqual: { code:'invalid', desc:'비밀번호가 일치하지 않습니다.'},
 		min: {code:'invalid', desc:'최소 8자 이상 입력하세요.' },
 		max: {code:'invalid', desc:'최대 16자 이내로 입력하세요.' },
 	},
 	pw_status:function(pw){
 		var reg = /[^a-zA-Z0-9!@#$%^&*_]/g;
 		var upper = /[A-Z]/g, lower = /[a-z]/g, digit = /[0-9]/g, special = /[!@#$%^&*_]/g;
 			title = $('[name=pw]').attr('title');
 		if( pw=='' ) return this.common.empty;
 		else if(pw.match(space) ) return this.common.space;
 		else if(reg.test(pw) ) return this.pw.invalid;
 		else if(pw.length<8) return this.pw.min;
 		else if(pw.length>17) return this.pw.max;
 		else if( !upper.test(pw) || !lower.test(pw) || !digit.test(pw) || !special.test(pw) ) return this.pw.lack;
 		else return this.pw.valid;
 	},
 	pw_ck_status: function(pw_ck){
 		title = $('[name=pw_ck]').attr('title');
 		if( pw_ck == '') return this.common.empty;
 		else if( pw_ck==$('[name=pw]').val() ) return this.pw.equal;
 		else return this.pw.notEqual;
 	},
 	
 	nickname:{
 		valid: { code:'valid',desc:'닉네임 중복확인버튼을 클릭해주세요.'},
 		invalid: { code:'invalid',desc:'닉네임은 한글만 입력하세요.'},
 		min: {code:'invalid', desc:'최소 2자 이상 입력하세요.' },
 		max: {code:'invalid', desc:'최대 8자 이내로 입력하세요.' },
 		usable: { code: 'valid', desc:'사용가능한 닉네임입니다.'},
 		unusable: {code: 'invalid', desc:'이미 사용중인 닉네임입니다.'},
 		
 	},
 	
 	nickname_usable: function(data){
 		if( data ) return this.nickname.usable;
 		else return this.nickname.unusable;
 	},
 	
 	nickname_status:function(nickname){
 		var reg = /[^가-힣]/;
 		if( nickname=='' ) return this.common.empty;
 		else if(nickname.match(space) ) return this.common.space;
 		else if(reg.test(nickname) ) return this.nickname.invalid;
 		else if(nickname.length<2) return this.nickname.min;
 		else if(nickname.length>9) return this.nickname.max;
 		else return this.nickname.valid;
 	},
 	
 	tel:{
 		valid: { code:'valid',desc:'사용가능한 전화번호입니다.'},
 		invalid: { code:'invalid',desc:'전화번호는 10~11자 숫자(집전화 및 휴대전화번호)만 입력가능합니다.'},
 	},
 	
 	tel_status:function(tel){
 		var reg = /^(070|02|031|032|033|041|042|043|051|052|053|054|055|061|062|063|064|010|011|016|017|018|019)\d{3,4}\d{4}$/u;
 		if( tel=='' ) return this.common.empty;
 		else if(tel.match(space) ) return this.common.space;
 		else if( !reg.test(tel) ) return this.tel.invalid;
 		else return this.tel.valid;
 	},
 	
 	tag_status: function(tag){
 		var data = tag.val();
 		
 		tag = tag.attr('name');
 		if(tag=='id') data = this.id_status(data);
 		else if( tag=='pw' ) data = this.pw_status(data);
 		else if( tag=='pw_ck') data = this.pw_ck_status(data);
 		else if( tag=='nickname' ) data = this.nickname_status(data);
 		else if( tag=='tel' ) data = this.tel_status(data);
 		return data;
 	}
 }