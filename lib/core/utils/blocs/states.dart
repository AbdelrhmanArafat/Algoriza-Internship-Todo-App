abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppCreatedDatabaseState extends AppStates {}

class AppLoadingDatabaseState extends AppStates {}

class AppGetFromDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppDeleteDatabaseState extends AppStates {}
