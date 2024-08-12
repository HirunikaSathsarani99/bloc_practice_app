class logOutRepository{

  Future<bool> logout() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
    
    
  }

}