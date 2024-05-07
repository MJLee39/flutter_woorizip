class ApiConfig {
  static const apiEndpointUrl = 'https://api.teamwaf.app';

  // condtion
  static const apiSubfixConditionUrl = '/v1/condition';
  // // save
  // static const apiSaveConditionUrl = '$apiSubfixConditionUrl/save';
  // // read
  // static const apiReadConditionUrl = '$apiSubfixConditionUrl/read';
  // readAll
  static const apiReadAllConditionUrl = '$apiSubfixConditionUrl/readAll';
  
  // auth
  static const apiSubfixAuthUrl = '/v1/auth';
  static const apiCheckAccountUrl = '$apiSubfixAuthUrl/checkAccount';
  static const apiValidateUrl = '$apiSubfixAuthUrl/validate';

  // account
  static const apiSubfixAccountUrl = '/v1/account';
  static const apiAccountUpdateUrl = '$apiSubfixAccountUrl/update';
  static const apiAccountDeleteUrl = '$apiSubfixAccountUrl/delete';

}
