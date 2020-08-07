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
 	member_email:{
 		valid: { code:'valid', desc:'아이디 중복확인버튼을 클릭해주세요.' },
 		invalid: { code:'invalid', desc:'아이디는 이메일 주소로 입력해주세요.' },
 		usable: { code: 'valid', desc:'사용가능한 아이디입니다. 해당 이메일로 전송된 인증번호를 입력해주세요.'},
 		unusable: {code: 'invalid', desc:'이미 사용중인 아이디입니다.'},
 	},
 	member_email_usable: function(data){
 		if( data ) return this.member_email.usable;
 		else return this.member_email.unusable;
 	},
 	member_email_status: function(member_email){
 		var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
 		title = $('[name=member_email]').attr('title');
 		if( member_email=='' ) return this.common.empty;
 		else if(member_email.match(space) ) return this.common.space;
 		else if( !reg.test(member_email) ) return this.member_email.invalid;
 		else return this.member_email.valid;
 	},
 	authNo:{
 		valid: {code:'valid', desc:'유효한 인증번호입니다.'},
 		invalid: {code:'invalid', desc:'유효하지 않은 인증번호입니다.'},
 	},
 	authNo_status: function(inputNum){
 	console.log(3, inputNum, '] > ', String(authNo), inputNum == String(authNo));
 		if( inputNum=='' ) return this.common.empty;
 		else if(inputNum.match(space) ) return this.common.space;
 		else if( inputNum == String(authNo) ) { console.log('valid'); return this.authNo.valid; }
 		else {  console.log('invalid'); return this.authNo.invalid; }
 	},
 	member_password:{
 		valid: { code:'valid',desc:'사용가능한 비밀번호입니다.'},
 		invalid: { code:'invalid',desc:'비밀번호는 영문 대/소문자, 숫자, 특수문자만 입력하세요.'},
 		lack:{ code:'invalid', desc:'비밀번호는 영문 대/소문자, 숫자, 특수문자를 모두 포함해야 합니다.'},
 		equal: { code:'valid', desc:'비밀번호가 일치합니다.'},
 		notEqual: { code:'invalid', desc:'비밀번호가 일치하지 않습니다.'},
 		min: {code:'invalid', desc:'최소 8자 이상 입력하세요.' },
 		max: {code:'invalid', desc:'최대 16자 이내로 입력하세요.' },
 	},
 	member_password_status:function(member_password){
 		var reg = /[^a-zA-Z0-9!@#$%^&*_]/g;
 		var upper = /[A-Z]/g, lower = /[a-z]/g, digit = /[0-9]/g, special = /[!@#$%^&*_]/g;
 			title = $('[name=member_password]').attr('title');
 		if( member_password=='' ) return this.common.empty;
 		else if(member_password.match(space) ) return this.common.space;
 		else if(reg.test(member_password) ) return this.member_password.invalid;
 		else if(member_password.length<8) return this.member_password.min;
 		else if(member_password.length>17) return this.member_password.max;
 		else if( !upper.test(member_password) || !lower.test(member_password) || !digit.test(member_password) || !special.test(member_password) ) return this.member_password.lack;
 		else return this.member_password.valid;
 	},
 	pw_ck_status: function(pw_ck){
 		title = $('[name=pw_ck]').attr('title');
 		if( pw_ck == '') return this.common.empty;
 		else if( pw_ck==$('[name=member_password]').val() ) return this.member_password.equal;
 		else return this.member_password.notEqual;
 	},
 	
 	member_nickname:{
 		valid: { code:'valid',desc:'닉네임 중복확인버튼을 클릭해주세요.'},
 		invalid: { code:'invalid',desc:'닉네임은 한글만 입력하세요.'},
 		min: {code:'invalid', desc:'최소 2자 이상 입력하세요.' },
 		max: {code:'invalid', desc:'최대 8자 이내로 입력하세요.' },
 		usable: { code: 'valid', desc:'사용가능한 닉네임입니다.'},
 		unusable: {code: 'invalid', desc:'이미 사용중인 닉네임입니다.'},
 		
 	},
 	
 	member_nickname_usable: function(data){
 		if( data ) return this.member_nickname.usable;
 		else return this.member_nickname.unusable;
 	},
 	
 	member_nickname_status:function(member_nickname){
 		var reg = /[^가-힣]/;
 		if( member_nickname=='' ) return this.common.empty;
 		else if(member_nickname.match(space) ) return this.common.space;
 		else if(reg.test(member_nickname) ) return this.member_nickname.invalid;
 		else if(member_nickname.length<2) return this.member_nickname.min;
 		else if(member_nickname.length>8) return this.member_nickname.max;
 		else return this.member_nickname.valid;
 	},
 	
 	member_phonenum:{
 		valid: { code:'valid',desc:'사용가능한 전화번호입니다.'},
 		invalid: { code:'invalid',desc:'전화번호는 10~11자 숫자(집전화 및 휴대전화번호)만 입력가능합니다.'},
 	},
 	
 	tel_status:function(member_phonenum){
 		var reg = /^(070|02|031|032|033|041|042|043|051|052|053|054|055|061|062|063|064|010|011|016|017|018|019)\d{3,4}\d{4}$/u;
 		if( member_phonenum=='' ) return this.common.empty;
 		else if(member_phonenum.match(space) ) return this.common.space;
 		else if( !reg.test(member_phonenum) ) return this.member_phonenum.invalid;
 		else return this.member_phonenum.valid;
 	},
 	
 	tag_status: function(tag){
 		var data = tag.val();
 	
 		
 		tag = tag.attr('name');
 		if(tag=='member_email') data = this.member_email_status(data);
 		else if( tag=='authNo' ) data = this.authNo_status(data);
 		else if( tag=='member_password' ) data = this.member_password_status(data);
 		else if( tag=='pw_ck') data = this.pw_ck_status(data);
 		else if( tag=='member_nickname' ) data = this.member_nickname_status(data);
 		else if( tag=='member_phonenum' ) data = this.tel_status(data);
 		return data;
 	}
 }