class ApiConfig {
  static const apiEndpointUrl = 'https://api.teamwaf.app';

  // condtion
  static const apiSubfixConditionUrl = '/v1/condition';
  // // save
  static const apiSaveConditionUrl = '$apiEndpointUrl$apiSubfixConditionUrl';
  // readAll
  static const apiReadAllConditionUrl = '$apiEndpointUrl$apiSubfixConditionUrl';
  // isRegistered
  static const apiIsRegisteredConditionUrl = '$apiEndpointUrl$apiSubfixConditionUrl/isRegistered';
  // readByWhere
  static const apiReadByWhereConditionUrl = '$apiEndpointUrl$apiSubfixConditionUrl/readByWhere';
  // readMy
  static const apiReadMyConditionUrl = '$apiEndpointUrl$apiSubfixConditionUrl/readMy';
  // delete
  static const apiDeleteConditionUrl = '$apiEndpointUrl$apiSubfixConditionUrl';
  // update
  static const apiUpdateConditionUrl = '$apiEndpointUrl$apiSubfixConditionUrl';


  // auth
  static const apiSubfixAuthUrl = '/v1/auth';
  static const apiLoginUrl = '$apiEndpointUrl$apiSubfixAuthUrl/login';
  static const apiGetAccountByTokenUrl= '$apiEndpointUrl$apiSubfixAuthUrl/account';
  static const apiValidationUrl = '$apiEndpointUrl$apiSubfixAuthUrl/validation';



  // account
  static const apiSubfixAccountUrl = '/v1/account';
  static const apiAccountUpdateUrl = '$apiEndpointUrl$apiSubfixAccountUrl';
  static const apiAccountDeleteUrl = '$apiEndpointUrl$apiSubfixAccountUrl';
  static const apiAccountReadAllUrl = '$apiEndpointUrl$apiSubfixAccountUrl';
  static const apiAccountLockUrl = '$apiEndpointUrl$apiSubfixAccountUrl';


  // zip
  static const apiSubfixZipUrl = '/v1/zip';

  // readAll
  static const apiReadAllZipUrl = '$apiEndpointUrl$apiSubfixZipUrl';
  // save
  static const apiSaveZipUrl = '$apiEndpointUrl$apiSubfixZipUrl';
  // update
  static const apiUpdateZipUrl = '$apiEndpointUrl$apiSubfixZipUrl';
  // getByAgentId
  static const apiGetByAgentIdZipUrl = '$apiEndpointUrl$apiSubfixZipUrl/agent';
  // getByEstateId
  static const apiGetByEstateIdZipUrl = '$apiEndpointUrl$apiSubfixZipUrl/estate';
  // search
  static const apiSearchZipUrl = '$apiEndpointUrl$apiSubfixZipUrl/search';
  // getByShowNo
  static const apiGetShowNoZipUrl = '$apiEndpointUrl$apiSubfixZipUrl/showNo';
  // getByShowYes
  static const apiGetShowYesZipUrl = '$apiEndpointUrl$apiSubfixZipUrl/showYes';
  // getById
  static const apiGetByIdZipUrl = '$apiEndpointUrl$apiSubfixZipUrl';
  // delete
  static const apiDeleteZipUrl = '$apiEndpointUrl$apiSubfixZipUrl';


  // Chat
  static const chatApiEndpointUrl = 'http://15.164.244.88:8080';

  // Attachment
  static const attachmentApiEndpointUri = 'https://file.teamwaf.app/attachment';

}
