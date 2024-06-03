abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppCreatedDatabaseState extends AppStates {}

class AppLoadingDatabaseState extends AppStates {}

class AppGetTaskFromDatabaseState extends AppStates {}

class AppInsertTaskToDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppDeleteTaskDataState extends AppStates {}

class AppRemindState extends AppStates {}

class AppRepeatState extends AppStates {}

class AppChangeColorIndexState extends AppStates {}
