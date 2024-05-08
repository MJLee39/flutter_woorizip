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
  
  static const apiAttachmentUrl = '$apiEndpointUrl/attachment';

  // auth
  static const apiSubfixAuthUrl = '/v1/auth';
  static const apiLoginUrl = '$apiEndpointUrl$apiSubfixAuthUrl/login';
  static const apiGetAccountByTokenUrl= '$apiEndpointUrl$apiSubfixAuthUrl/account';
  static const apiValidationUrl = '$apiEndpointUrl$apiSubfixAuthUrl/validation';



  // account
  static const apiSubfixAccountUrl = '/v1/account';
  static const apiAccountUpdateUrl = '$apiEndpointUrl$apiSubfixAccountUrl/update';
  static const apiAccountDeleteUrl = '$apiEndpointUrl$apiSubfixAccountUrl/delete';

}
