public with sharing class WeekDaysBetweenTwoDates {
    public static List<String> getWeekDays(Date startDate, Date endDate) {
        List<String> weekDays = new List<String>();
            
        //Looping in between the startDate and endDate to add Day in the weekDays list
        for(Date currentDate = startDate; currentDate <= endDate; currentDate = currentDate.addDays(1)){
            DateTime dt = (DateTime)currentDate;  //changing the Date into DateTime because the .format('EEEE')
            String currentDay = dt.format('EEEE');   //current iteration's Day 
            if(currentDay!='Saturday' && currentDay!='Sunday'){ //checking if the the current day is Sunday or Saturday 
                weekDays.add(currentDay); //If not weekend add it to the list 
            }

        }
        return weekDays;
    }
    public static void testGetWeekDays(){
        Date startDate = Date.newInstance(2024, 12, 1);
        Date endDate = Date.newInstance(2024, 12, 7);

        List<String> weekDays = WeekDaysBetweenTwoDates.getWeekDays(startDate, endDate);
        System.debug(weekDays);
    }
     
}