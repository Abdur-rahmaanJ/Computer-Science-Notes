

public class AlarmApplication {
	public static void main(String[] args) {
		AlarmClock alarmClock = new AlarmClock();
		alarmClock.setAlarmTime(7, 30, 0);
		Person jack = new Person("Jack");
		jack.goToBed();
		for (int i = 1; i <= SECONDS_IN_DAY; i++) {
			alarmClock.tick();
			if (alarmClock.alarmReached()) {
				System.out.println("The time is: " + alarmClock.getTime());
				jack.wakeUp();
			}
		}
	}
	public static final int SECONDS_IN_DAY = 86400;
	
	

}