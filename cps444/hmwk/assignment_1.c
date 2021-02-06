/**
 * assignment_1.c
 *
 * Author: Evan Krimpenfort
 */

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/*
 * 1. Identify and correct the errors in each of the following statements. (Note: There may be more than one error per statement.)
 *
 * 	a. scanf("%d", value);
 * 	b. printf("The product of %d and %d is %d\n", x, y, z);
 * 	c. sumOfNumbers = firstNumber + secondNumber;
 * 	d. if (number >= largest) 
 * 	   {
 * 	   	largest = number;
 * 	   }
 * 	e. // Program to determine the largest of three integers //
 * 	f. scanf("%d", &anInteger);
 *	g. printf("Remainder of %d divided by %d is %d\n", x, y, x % y);
 *	h. if (x == y)
 *	   {
 *	   	printf("%d is equal to %d\n", x, y);
 *	   }
 *	i. printf("The sum is %d\n", x + y);
 *	j. printf("The value you entered is: %d\n", value);
 *	k. if (age >= 65)
 *	   {
 *	   	printf("Age is greater than or equal to 65.");
 *	   }
 *	   else 
 *	   {
 *	   	printf("Age is less than 65.");
 *	   }
 *	l. int x = 1;
 *	   int total;
 *	   while (x <= 10)
 *	   {
 *	   	total += x;
 *	   	++x;
 *	   }
 *	m. while (x <= 100)
 *	   {
 *	   	total += x;
 *	   	++x;
 *	   }
 *	n. int y = -100;
 *	   while (y > 0)
 *	   {
 *	   	printf("%d\n", y);
 *	   	++y;
 *	   }
 *	   // original was an infinite loop
 *	o. for (int x = 100; x >= 1; --x)
 *	   {
 *	   	printf("%d\n", x);
 *	   }
 *	   // original was an infinite loop
 *	p. for (double x = 0.000001; x <= 0.0001; x += 0.000001)
 *	   {
 *	   	printf("%.6f\n", x);
 *	   }
 *	q. The following code should output the odd integers from 999 to 1:
 *	   for (int x = 999; x >= 1; x -= 2)
 *	   {
 *	   	printf("%d\n", x);
 *	   }
 *	r. The following code should sum the integers from 100 to 150 (assume the total is initialized to 0):
 *	   for (int x = 100; x <= 150; x++)
 *	   {
 *	   	total += x;
 *	   }
 *
 * 2. Write a Single C statement or line that accomplishes each of the following.
 *
 *	a. Print the message "Enter two numbers."
 *	   printf("Enter two numbers.");
 *	b. Assign the product of variables b and c to variable a.
 *	   a = b * c;
 *	c. state that a program performs a simple payroll calculation
 *	   // This program performs a simple payroll calculation.
 *	d. Input three integer values from the keyboard and place them in integer variables a, b, and c.
 *	   scanf("Input three integers into a, b, and c: ", &a, &b, &c);
 *
 * 3. state which of the following are true and which are false. if false, explain your answer.
 * 	
 * 	a. c operators are evaluated from left to right.
 * 	   FALSE. they are evaluated from right to left. see 2.b.
 * 	b. the following are all valid variables names (see hmwk1)
 *	   TRUE.
 *	c. The statement printf("a = 5;"); is a typical example of an assignment statement.
 *	   FALSE. the statement compiles but that is not how you assign variables. 
 *	   all you need to do is type a = 5; and that involves no print statement.
 *	d. A valid arithmetic expression containing no parenthesis is evaluated from left to right.
 *	   TRUE.
 *	e. The following are all invalid variable names: (see hmwk1)
 *	   FALSE. the fourth one (h22) is a valid variable name. the rest are not.
 *
 * 4. what, if anything, prints when each of the following statements is performed? 
 *    if nothing prints, then answer "nothing."
 *    assume x = 2 and y = 3
 *    	
 *    	a. 2
 *    	b. 4
 *    	c. x=
 *    	d. x=2
 *    	e. 5=5
 *    	f. nothing
 *    	g. nothing
 *    	h. x + y = 5
 *    	i. nothing
 *
 * 5. which, if any, of the following c statements contain variables whose values are replaced?
 * 	
 * 	a. b, c, d, e, and f
 * 	b. p
 * 	c. none
 * 	d. none
 *
 * 6. Given the equation y = ax^3 + 7, which of the following, if any, are correct C statements for this equation?
 * 	
 * 	The ones that are correct are a and e.
 *
 * 7. State the order of evaluation of the operators in each of the following C statements and show the value of x 
 *    after each statement is performed.
 *	
 *	PEMDAS
 *	a. x = 7 + 3 * 6 / 2 - 1;
 *	3. 3 * 6 = 18
 *	3. 18 / 2 = 9
 *	4. 7 + 9 = 16
 *	4. 16 - 1 = (15)
 *	   
 *	b. x = 2 % 2 + 2 * 2 - 2 / 2;
 *	3. 2 % 2 = 0
 *	3. 2 * 2 = 4
 *	3. 2 / 2 = 1
 *	4. 0 + 4 = 4
 *	4. 4 - 1 = (3)
 *
 *	c. x = ( 3 * 9 * ( 3 + ( 9 * 3 / ( 3 ) ) ) );
 *	1. (3) = 3
 *	1. (9 * 3 / 3) --> 3. 9 * 3 = 27
 *		       --> 3. 27 / 3 = 9
 *	1. (3 + 9) --> 4. 3 + 9 = 12
 *	1. (3 * 9 * 12) --> 3. 3 * 9 = 27
 *			--> 3. 27 * 12 = (324)
 *	
 * 8. What does the following program print?
 * 	
 * 	#include <stdio.h>
 * 	int main( void )
 *	{
 *		unsigned int x = 1, total = 0, y;
 *
 *		while ( x <= 10 ) 
 *		{
 *			y = x * x;
 *			printf( "%d\n", y );
 *			total += y;
 *			++x;
 *		} // end while
 *
 *	printf( "Total is %d\n", total );
 *	} // end main
 *
 *	This program prints...
 *	1
 *	4
 *	9
 *	16
 *	25
 *	36
 *	49
 *	64
 *	81
 *	100
 *	Total is 385
 *
 * 9. State which values of the control variable x are printed by each of the following for statements:
 * 	
 * 	a. 2, 4, 6, 8, 10, 12
 * 	b. 5, 12, 19
 * 	c. 3, 6, 9, 12, 15
 * 	d. 1
 * 	e. 12, 9, 6, 3
 *
 * 10. Write for statements that print the following sequences of values:
 *
 * 	a. for (int x = 1; x <= 7; x++) 
 * 	   {
 *		printf("%d\n", x);
 *	   }
 *	b. for (int x = 3; x <= 23; x += 5)
 *	   {
 *		printf("%d\n", x);
 *	   }
 *	c. for (int x = 20; x >= -10; x -= 6)
 *	   {
 *		printf("%d\n", x);
 *	   }
 *	b. for (int x = 19; x <= 51; x += 8)
 *	   {
 *		printf("%d\n", x);
 *	   }
 *
 * 11. (Truth Tables) Complete the following truth tables by filling in each blank with 0 or 1.
 *
 * 	Condition 1	Condition 2	Condition 1 && Condition 2
 * 	0		0		0
 * 	0		nonzero		0
 * 	nonzero		0		0
 * 	nonzero		nonzero		1
 *
 * 	----------------------------------------------------------
 * 	Condition 1	Condition 2	Condition 1 || Condition 2
 *	0		0		0
 *	0		nonzero		1
 *	nonzero		0		1
 *	nonzero		nonzero		1
 *
 * 	----------------------------------------------------------
 * 	Condition 1	!Condition 1
 * 	0		1
 * 	nonzero		0
 */


/* C FUNCTIONS
 * 1. Define a function called hypotenuse that calculates the length of the hypotenuse of a right triangle 
 *    when the other two sides are given. The function should consume two arguments of type double and 
 *    produce the hypotenuse as a double. Test your program with the side values specified in the following table:
 */
double hypotenuse(double side_1, double side_2)
{
	return sqrt(pow(side_1, 2) + pow(side_2, 2));
}

/* 
 * 2.Write a function integerPower(base, exponent) that produces the value of
 * 	base^exponent
 *   For example, integerPower( 3, 4 ) = 3 * 3 * 3 * 3. Assume that exponent is a positive, nonzero integer, 
 *   and base is an integer. Function integerPower should use for to control the calculation. 
 *   Do not use any math library functions.
 */
int integerPower(int base, int exponent)
{
	int product = 1;
	for (int i = 0; i < exponent; i++)
	{
		product *= base;
	}
	return product;
}

/*
 * 3. Write a function multiple that determines for a pair of integers whether the second integer is a 
 *    multiple of the first. The function should consume two integer arguments and produce 1 (true) 
 *    if the second is a multiple of the first, and 0 (false) otherwise. Use this function in a program 
 *    that inputs a series of pairs of integers.
 */
int multiple(int number, int multiple)
{
	return multiple % number == 0;
}

/*
 * 4. Write a function that displays a solid square of asterisks whose side is specified in integer 
 *    parameter side. For example, if side is 4, the function displays:
 */
void printASquareOfAstericks(int side_length)
{
	for (int i = 0; i < side_length; i++)
	{
		for (int j = 0; j < side_length; j++)
		{
			printf("*");
		}
		printf("\n");
	}
}

/*
 * 5. Modify the function created in question 4 (Square of Asterisks), above, to form the square out 
 * of whatever character is contained in character parameter fillCharacter. Thus if side is 5 and fillCharacter 
 * is "#", then this function should print:
 */
void printASquareOfACharacter(int side_length, char fill_character)
{
	for (int i = 0; i < side_length; i++)
	{
		for (int j = 0; j < side_length; j++)
		{
			printf("%c", fill_character);
		}
		printf("\n");
	}
}

/*
 * 6. Write a function that consumes the time as three integer arguments (for hours, minutes, and seconds) 
 *    and produces the number of seconds since the last time the clock "struck 12." Use this function 
 *    to calculate the amount of time in seconds between two times, both of which are within 
 *    one 12-hour cycle of the clock.
 */
void timeInSeconds(int hours, int minutes, int seconds)
{
	const int SECONDS_PER_MINUTE = 60;
	const int SECONDS_PER_HOUR = 3600;

	int total_seconds = seconds;
	total_seconds += (minutes * SECONDS_PER_MINUTE);
	total_seconds += (hours * SECONDS_PER_HOUR);

	printf("The total amount of seconds is %d.\n", total_seconds);
}

/*
 * 7. a) Function celsius produces the Celsius equivalent of a Fahrenheit temperature.
 *    b) Function fahrenheit produces the Fahrenheit equivalent of a Celsius temperature.
 *    c) Use these functions to write a program that prints charts showing the Fahrenheit equivalents of 
 *    all Celsius temperatures from 0 to 100 degrees, and the Celsius equivalents of all Fahrenheit temperatures 
 *    from 32 to 212 degrees. Print the outputs in a tabular format that minimizes the number 
 *    of lines of output while remaining readable.
 */
double celsiusToFahrenheit(double celsius)
{
	return (celsius * 1.8) + 32;
}
double fahrenheitToCelsius(double fahrenheit)
{
	return (fahrenheit - 32) / 1.8;
}
void temperatureConversionChart()
{
	// all celsiusToFahrenheit temperatures
	int i = 0;
	printf("C to F:\n");
	for (int c = 0; c <= 100; c++)
	{
		printf("C:%d - F:%.1f\t", c, celsiusToFahrenheit(c));
		i++;
		if (i == 5)
		{
			printf("\n");
			i = 0;
		}
	}
	i = 0;
	printf("\n\nF to C:\n");
	// all fahrenheitToCelsius temperatures
	for (int f = 32; f <= 212; f++)
	{
		printf("F:%d - C:%.1f\t", f, fahrenheitToCelsius(f));
		i++;
		if (i == 5)
		{
			printf("\n");
			i = 0;
		}
	}
	printf("\n");
}

/*
 * 8. Write a function that produces the smallest of three floating-point numbers.
 */
double minimum(double number_1, double number_2, double number_3)
{
	if (number_1 < number_2 && number_1 < number_3) { return number_1; }
	else if (number_2 < number_1 && number_2 < number_3) { return number_2; }
	else if (number_3 < number_2 && number_3 < number_1) { return number_3; }
}

/*
 * 9. An integer number is said to be a perfect number if its factors, including 1 
 * (but not the number itself), sum to the number. For example, 6 is a perfect number because 6 = 1 + 2 + 3. 
 * Write a function perfect that determines whether parameter number is a perfect number. 
 * Use this function in a program that determines and prints all the perfect numbers between 1 and 1000. 
 * Print the factors of each perfect number to confirm that the number is indeed perfect. 
 * Challenge the power of your system by testing numbers much larger than 1000.
 */
int perfectNumber(int number)
{
	int isPerfect = 1;
	int sum = 0;
	int i = 0;
	while(isPerfect)
	{
		i++;
		sum += i;
		if (number == sum) { return 1; }
		else if (number < sum) { isPerfect = 0; }
	}
	return 0;
}
void perfectNumbersChart() 
{
	printf("Perfect Numbers are... ");
	for (int i = 0; i <= 1000; i++)
	{
		if (perfectNumber(i))
		{
			printf("%d, ", i);
		}	
	}
	printf("\n");
}

/*
 * 10. An integer is said to be prime if it’s divisible by only 1 and itself. For example, 2, 3, 5 and 7 
 * are prime, but 4, 6, 8 and 9 are not.
 * 
 * a) Write a function that determines whether a number is prime.
 *
 * b) Use this function in a program that determines and prints all the prime numbers between 1 and 10,000. 
 *    How many of these 10,000 numbers do you really have to test before being sure that you have found all the primes?
 *
 * c) Initially you might think that n/2 is the upper limit for which you must test to see whether 
 *    a number is prime, but you need go only as high as the square root of n. Rewrite the program, 
 *    and run it both ways. Estimate the performance improvement.
 */
int prime(int number)
{
	if (number == 2 || number == 3) { return 1; }
	else if (number <= 1 || number % 2 == 0 || number % 3 == 0) { return 0; }

	int i = 5;
	while (pow(i, 2) <= number)
	{
		if (number % i == 0 || number % (i + 2) == 0) { return 0; }
		i += 6;
	}

	return 1;
}
int primeChart()
{
	printf("Prime Numbers are... ");
	for (int i = 0; i <= 10000; i++)
	{
		if (prime(i))
		{
			printf("%d, ", i);
		}	
	}
	printf("\n");
}

/*
 * 11. Write a function that consumes an integer value and produces the number with its digits reversed. 
 * For example, given the number 7631, the function should produce 1367.
 */
void reverseDigits(int number)
{
	char number_string[4];
	char reverse_string[4];
	char temp;
	sprintf(number_string, "%d", number);
	strcpy(reverse_string, number_string);
	for (int i = 0; i < sizeof(reverse_string)/2; i++)
	{
		temp = reverse_string[i];
		reverse_string[i] = reverse_string[sizeof(reverse_string) - 1 - i];
		reverse_string[sizeof(reverse_string) - 1 - i] = temp;
	}
	printf("Original number was %d but now it's %s.\n", number, reverse_string);
}

/*
 * 12. The greatest common divisor (GCD) of two integers is the largest integer that evenly divides 
 *     each of the two numbers. Write function gcd that returns the greatest common divisor of two integers.  
 *
 *     Didn't know what this was, so I looked up ways to do this by hand and I found the Euclidean method.
 */
int gcd(int number_1, int number_2)
{
	int temp = 0;
	while (number_1 != 0)
	{
		temp = number_1;
		number_1 = number_2 % number_1;
		number_2 = temp;
	}
	return number_2;
}

/*
 * 13. Write a function qualityPoints that inputs a student’s average and produces 4 it’s 90–100, 3 if it’s 80–89, 
 *     2 if it’s 70–79, 1 if it’s 60–69, and 0 if the average is lower than 60.
 */
int qualityPoints(int grade)
{
	if (grade <= 100 && grade > 89) { return 4; }
	else if (grade <= 89 && grade > 79) { return 3; } 
	else if (grade <= 79 && grade > 69) { return 2; } 
	else if (grade <= 69 && grade > 59) { return 1; } 
	else if (grade <= 69) { return 0; } 
	else { return -1; }
}

/*
 * 14. The Fibonacci series
 *     0, 1, 1, 2, 3, 5, 8, 13, 21, ...
 *
 *     begins with the terms 0 and 1 and has the property that each succeeding term is the sum of the two preceding terms.
 *     
 *     a) Write a function fibonacci(n) that calculates the nth Fibonacci number. Use unsigned int 
 *     for the function’s parameter and unsigned long for its return type.
 *
 *     b) Determine the largest Fibonacci number that can be calculated by your function on your system.
 */
int fibonacci(int number)
{
	int a = 0;
	int b = 1;
	int sum = a + b;
	if (number == 1) { return a; }
	else if (number == 2) { return b; }
	
	while (number > 3)
	{
		a = b;
		b = sum;
		sum = a + b;
		number--;
	}
	return sum;
}

/* 
 * C Arrays
 * 15. a)    Display the value of the seventh element of character array f.
 * 	- f[6];
 *
 *     b)    Input a value into element 4 of floating-point array b.
 *      - b[3] = 6.2;
 *
 *     c)    Initialize each of the five elements of integer array g to 8.
 *      - for (int i = 0; i < 5; i++) { g[i] = 8; }
 *
 *     d)    Total the elements of floating-point array prices of 100 elements.
 *      - int total = 0;
 *        for (int i = 0; i < 100; i++) { total += prices[i]; }
 *
 *     e)    Copy array a into the first portion of array b. Assume double a[11], b[34];
 *      - for (int i = 0; i < sizeof(a); i++) 
 *        { 
 *        	b[i] = a[i]; 
 *        }
 *       
 *     f)    Determine and print the smallest and largest values contained in 99-element floating-point array w.
 *      - int largest = w[0], smallest = w[0];
 *        for (int i = 1; i < 99; i++) 
 *        { 
 *        	if (w[i] < smallest) { smallest = w[i]; }
 *        	if (w[i] > largest) { largest = w[i]; } 
 *        }
 *        printf("largest = %d, smallest = %d.\n", largest, smallest);
 */

/*
 * 16. Use an array to solve the following problem. A company pays its salespeople on a commission basis. 
 *     The salespeople receive $200 per week plus 9% of their gross sales for that week. For example, 
 *     a salesperson who grosses $3,000 in sales in a week receives $200 plus 9% of $3,000, or a total of $470. 
 *     Write C program code (using an array of counters) that determines how many of the salespeople earned 
 *     salaries in each of the following ranges (assume that each salesperson’s salary is 
 *     truncated to an integer amount):
 *
 *     a) $200–299
 *     b) $300–399
 *     c) $400–499
 *     d) $500–599
 *     e) $600–699
 *     f) $700–799
 *     g) $800–899
 *     h) $900–999
 *     i) $1000 and over
 */
int *salaryRanges(int *salaries)
{
	static int range[9];
	for (int i = 0; i < sizeof(salaries); i++)
	{
		if (salaries[i] < 300 && salaries[i] >= 200) { range[0]++; }
		else if (salaries[i] < 400 && salaries[i] >= 300) { range[1]++; }
		else if (salaries[i] < 500 && salaries[i] >= 400) { range[2]++; }
		else if (salaries[i] < 600 && salaries[i] >= 500) { range[3]++; }
		else if (salaries[i] < 700 && salaries[i] >= 600) { range[4]++; }
		else if (salaries[i] < 800 && salaries[i] >= 700) { range[5]++; }
		else if (salaries[i] < 900 && salaries[i] >= 800) { range[6]++; }
		else if (salaries[i] < 1000 && salaries[i] >= 900) { range[7]++; }
		else if (salaries[i] >= 1000) { range[8]++; }
	}
	return range;
}

/*
 * 17. Write C loops that perform each of the following array operations:
 *     a)    Initialize the 10 elements of integer array counts to zeros.
 *      - int arr[10];
 *        for (int i = 0; i < 10; i++)
 *        {
 *		arr[i] = 0;
 *        } 
 *
 *     b)    Add 1 to each of the 15 elements of integer array bonus.
 *      - for (int i = 0; i < 15; i++)
 *        {
 *		arr[i]++;
 *        } 
 *
 *     c)    Read the 12 values of floating-point array monthlyTemperatures from the keyboard.
 *      - double arr[12];
 *        printf("Enter in floating: ");
 *        for (int i = 0; i < 12; i++)
 *        {
 *		scanf("%f",&arr[i]);
 *        } 
 *
 *     d)    Print the five values of integer array bestScores in column format.
 *      - for (int i = 0; i < 5; i++)
 *        {
 *		printf("bestscore %d: %-20d", i, arr[i]);
 *        } 
 */

/*
 * 18. Use an array to solve the following problem: Read in 20 numbers, each of which is between 
 *     10 and 100, inclusive. As each number is read, print it only if it’s not a duplicate of a number 
 *     already read. Provide for the "worst case" in which all 20 numbers are different. Use the 
 *     smallest possible array to solve this problem.
 */
void eliminateDuplicates()
{
	int size = 1;
	int total = 0;
	int *unique = malloc(sizeof(*unique) * size);
	int number;
	time_t t;
	
	srand((unsigned) time(&t));
	
	for (int i = 0; i < 20; i++)
	{
		number = (rand() % 90) + 10;
		for (int j = 0; j < size; j++)
		{
			if (unique[j] == number) { number = -1; }
		}

		if (number != -1)
		{
			printf("Unqiue Number: %d\n", number);
			unique[total] = number;
			total++;
			if (total == size)
			{
				size *= 2;
				unique = realloc(unique, sizeof(*unique) * size);
			}
		}
	}
}

/*
 * main will test all functions above.
 */
int main()
{
	// question 1
	printf("Hypotenuse with sides %.1f and %.1f is %.1f.\n", 3.0, 4.0, hypotenuse(3.0, 4.0));
	printf("Hypotenuse with sides %.1f and %.1f is %.1f.\n", 5.0, 12.0, hypotenuse(5.0, 12.0));
	printf("Hypotenuse with sides %.1f and %.1f is %.1f.\n", 8.0, 15.0, hypotenuse(8.0, 15.0));

	// question 2
	printf("The product of a base of %d and exponent %d is %d.\n", 3, 4, integerPower(3, 4));

	// question 3
	int a = 0, b = 0;
	printf("Enter in a number and a multiple you want to find (space them apart): ");
	scanf("%d %d", &a, &b);
	if (multiple(a, b) == 1)
	{
		printf("The number %d IS a multiple of %d.\n", b, a);
	}
	else
	{	
		printf("The number %d is NOT a multiple of %d.\n", b, a);
	}

	// question 4
	printASquareOfAstericks(4);

	// question 5
	printASquareOfACharacter(5, '#');

	// question 6
	int c = 0;
	printf("Enter hours, minutes, and seconds you want to find the total amount of seconds (space between): ");
	scanf("%d %d %d", &a, &b, &c);
	timeInSeconds(a, b, c);

	// question 7
	temperatureConversionChart();

	// question 8
	printf("The minimum of numbers %.1f, %.1f, and %.1f is %.1f.\n", 3.1, 7.4, 4.6, minimum(3.1, 7.4, 4.6));

	// question 9
	perfectNumbersChart();

	// question 10
	primeChart();

	// question 11
	reverseDigits(7631);

	// question 12
	printf("The Greatest Common Divisior of %d and %d is %d.\n", 98, 56, gcd(98, 56));

	// question 13
	printf("The Quality Points of a %d grade point is %d.\n", 82, qualityPoints(82));

	// question 14
	printf("The %d number in the fibonacci sequence is %d.\n", 8, fibonacci(8));

	return(0);
}
