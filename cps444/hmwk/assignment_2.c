/**
 * Author: Evan Krimpenfort
 *
 * Project: Assignment_2.c
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define LEN(array) sizeof(array)/sizeof(*array)

/*
 * 1. What will this program print?
 *    8 8
 *    4 4
 *    0 0 
 *    2 2 
 */
void question_1()
{
  int ref[] = {8, 4, 0, 2};
  int *ptr;
  int index;

  for (index = 0, ptr = ref; index < 4; index++, ptr++)
     printf("%d %d\n", ref[index], *ptr);
}

/*
 * 2. Write a program that initializes an array-of-double and then copies the contents of the array into 
 *    three other arrays. (All four arrays should be declared in the main program.) To make the first copy, 
 *    use a function with array notation. To make the second copy, use a function with pointer notation 
 *    and pointer incrementing. Have the first two functions take as arguments the name of the target array, 
 *    the name of the source array, and the number of elements to be copied. Have the third function take 
 *    as arguments the name of the target, the name of the source, and a pointer to the element following the 
 *    last element of the source. That is, the function calls would look like this, given the following declarations:
 *
 *    double source[5] = {1.1, 2.2, 3.3, 4.4, 5.5};
 *    double target1[5];
 *    double target2[5];
 *    double target3[5];
 *    copy_arr(target1, source, 5);
 *    copy_ptr(target2, source, 5);
 *
 *    copy_ptrs(target3, source, source + 5);
 */
void copy_arr(double *target, double *source, int size)
{
	for (int i = 0; i < size; i++)
	{
		target[i] = source[i];
	}
}
void copy_ptr(double *target, double *source, int size)
{
	for (int i = 0; i < size; i++, target++, source++)
	{
		*target = *source;
	}
}
void copy_ptrs(double *target, double *source, double *source_ending_position)
{
	while (*source != *source_ending_position)
	{
		*target = *source;
		target++;
		source++;
	}
}
void print_arr(double* arr, int size)
{
	for (int i = 0; i < size; i++)
	{
		printf("%.1f\n", arr[i]);
	}
}

/*
 * 3. Write a function that returns the largest value stored in an array-of-int. Test the function in a simple program.
 */
int largest(int *arr, int size)
{
	int largest = arr[0];   

	for (int i = 1; i < size; i++)
	{
		if (largest < arr[i])
		{
			largest = arr[i];
		}
	}

	return largest;
}
/*
 * 4. Write a function that returns the index of the largest value stored in an array-of-double. 
 *    Test the function in a simple program.
 */
int largestIndex(double *arr, int size)
{
	int largest_index = 0;

	for (int i = 1; i < size; i++)
	{
		if (arr[largest_index] < arr[i])
		{
			largest_index = i;
		}
	}

	return largest_index;
}

/*
 * 5. Write a function that returns the difference between the largest and smallest elements of an array-of-double. 
 *    Test the function in a simple program.
 */
double difference(double *arr, int size)
{
	double largest = arr[0];
	double smallest = arr[0];

	for (int i = 1; i < size; i++)
	{
		if (largest < arr[i])
		{
			largest = arr[i];
		}
		else if (smallest > arr[i])
		{
			smallest = arr[i];
		}
	}

	return largest - smallest;
}

/*
 * 6. Write a function that reverses the contents of an array of double and test it in a simple program.
 */
void reverseArray(double *arr, int size)
{
        double temp;
        for (int i = 0; i < size/2; i++)
        {
                temp = arr[i];
                arr[i] = arr[size - 1 - i];
                arr[size - 1 - i] = temp;
        }
}

/*
 * 7. What will this program print?
 *    See you at the snack bar.
 *    ee you at the snack bar.
 *    See you
 *    e you
 */
void question_7()
{
   char note[] = "See you at the snack bar.";
   char *ptr;

   ptr = note;
   puts(ptr);
   puts(++ptr);
   note[7] = '\0';
   puts(note);
   puts(++ptr);
}

/*
 * 8. What will this program print?
 *    y
 *    my
 *    mmy
 *    ummy
 *    Yummy
 */
void question_8()
{
	char food[] = "Yummy";
   	char *ptr;

   	ptr = food + strlen(food);
   	while (--ptr >= food)
        	puts(ptr);
}

/*
 * 9. What will the following program print?
 *    I read part of it all the way through.
 */
void question_9()
{
	char goldwyn[40] = "art of it all ";
    	char samuel[40] = "I read p";
    	const char * quote = "the way through.";

    	strcat(goldwyn, quote);
    	strcat(samuel, goldwyn);
    	puts(samuel);
}

/*
 * 10. Consider the following function call:
 *     x = pr("Ho Ho Ho!");
 *
 *     a. What is printed?
 *	  Ho Ho Ho!!oH oH oH
 *     b. What type should x be?
 *        char*
 *     c. What value does x get?
 *	  Ho Ho Ho!
 *     d. What does the expression *--pc mean, and how is it different from --*pc?
 *	  *--pc means count down one char's worth of space and then dereference the string to get the character
 *	  at that location. --*pc is different because you are dereferencing first and then subtracting one from
 *	  the ascii value.
 *     e. What would be printed if *--pc were replaced with *pc--?
 *	  everything but the H at the end because the decrement is after the while loops. 
 *	  !oH oH o  
 *     f. What do the two while expressions test for?
 *	  The first expression tests for if the char* pc can dereference itself. The second loops tests to see
 *	  if the char* str and pc have the same pointer value (starting address).
 *     g. What happens if pr() is supplied with a null string as an argument?
 *	  breaks. The first while loop is fine but because the second one is vulnerable to the null since it's a 
 *	  "do" while.
 *     h. What must be done in the calling function so that pr() can be used as shown?
 *	  the string put inside of pr() cannot be null.
 */
char *pr (char *str)
{
	char *pc;

	pc = str;
	while (*pc)
		putchar(*pc++);
 	do 
	{
     		putchar(*--pc); // can replace with *pc--
     	} 
	while (pc - str);
  	return (pc);
}

/*
 * 11. What does the following program print?
 *     How are ya, sweetie? How are ya, sweetie?
 *     Beat the clock.
 *     eat the clock.
 *     Beat the clock. Win a toy.
 *     Beat
 *     chat
 *     hat
 *     at
 *     t
 *     t
 *     at
 *     How are ya, sweetie? 
 */
#define M1   "How are ya, sweetie? "
char M2[40] = "Beat the clock.";
char * M3  = "chat";
void question_11()
{
     char words[80];
     printf(M1);
     puts(M1);
     puts(M2);
     puts(M2 + 1);
     strcpy(words,M2);
     strcat(words, " Win a toy.");
     puts(words);
     words[4] = '\0';
     puts(words);
     while (*M3)
        puts(M3++);
     puts(--M3);
     puts(--M3);
     M3 = M1;
     puts(M3);
}

/*
 * 12. What does the following program print?
 *     faavrhee
 *     *le*on*sm
 */ 
void question_12()
{
    char str1[] = "gawsie";     // plump and cheerful
    char str2[] = "bletonism";
    char *ps;
    int i = 0;

    for (ps = str1; *ps != '\0'; ps++) {
         if ( *ps == 'a' || *ps == 'e')
                putchar(*ps);
         else
                (*ps)--;
         putchar(*ps);
        }
    putchar('\n');
    while (str2[i] != '\0' ) {
       printf("%c", i % 3 ? str2[i] : '*');
       ++i;
       }
}

/*
 * 13. Design and test a function that fetches the next n characters from input (including 
 *     blanks, tabs, and newlines), storing the results in an array whose address is passed 
 *     as an argument.
 */
void nfetch(char* string, int n, char* result)
{
	for (int i = 0; i < n; i++)
	{
		*result++ = *string++;
	}
}

/*
 * 14. Design and test a function that searches the string specified by the first function parameter 
 *     for the first occurrence of a character specified by the second function parameter. Have the 
 *     function return a pointer to the character if successful, and a null if the character is not 
 *     found in the string. (This duplicates the way that the library strchr() function works.) Test the 
 *     function in a complete program that uses a loop to provide input values for feeding to the function.
 */
char* search_char(char* string, char c)
{
	while (*string)
	{
		if (*string == c)
			return string;
		else
			string++;
	}
	return NULL;
}

/*
 * 15. Write a function called contains() that takes a character and a string pointer as its two 
 *     function parameters. Have the function return a nonzero value (true) if the character is in 
 *     the string and zero (false) otherwise. Test the function in a complete program that uses a 
 *     loop to provide input values for feeding to the function.
 */
int contains(char* string, char c)
{
	while (*string)
	{
		if (*string == c)
			return 1;
		else
			string++;
	}
	return 0;
}

/*
 * 16. The strncpy(s1,s2,n) function copies exactly n characters from s2 to s1, truncating s2 or 
 *     padding it with extra null characters as necessary. The target string may not be null-terminated 
 *     if the length of s2 is n or more. The function returns s1. Write your own version of this function; 
 *     call it mystrncpy(). Test the function in a complete program that uses a loop to provide input 
 *     values for feeding to the function.
 */
char* mystrncpy(char* s1, char* s2, int n)
{
	char* str = s1;
	*(s2+n) = '\0';
	while (*s2)
	{
		*s1 = *s2;
		s1++;
		s2++;
	}
	while (s1 - str)
	{
		s1--;
	}
	return s1;	
}

/*
 * 17. Write a function called index_of() that takes two string pointers as arguments. If the second 
 *     string is contained in the first string, have the function return the index at which the contained 
 *     string begins. For instance, string_in("hats", "at") would return the index (1) of the a in hats. 
 *     Otherwise, have the function return -1. Test the function in a complete program that uses a 
 *     loop to provide input values for feeding to the function.
 */
int index_of(char* word, char* string)
{
	char* loop = string;
	int i = 0;
	int j = 0;
	while (*word)
	{
		if (*word == *loop)
		{
			loop++;
			if (*loop == '\0')
			{
				return i - (strlen(string) - 1);
			}
		}
		else
		{
			loop = string;
		}
		word++;
		i++;
	}
	return -1;
}

/*
 * 18. Write a program with the following behavior. First, it asks you how many words you wish to enter. 
 *     Then it has you enter the words, and then it displays the words. Use malloc() and the answer to 
 *     the first question (the number of words) to create a dynamic array of the corresponding number of 
 *     pointers-to-char. (Note that because each element in the array is a pointer-to-char, the pointer 
 *     used to store the return value of malloc() should be a pointer-to-a-pointer-to-char.) When reading 
 *     the string, the program should read the word into a temporary array of char, use malloc() to 
 *     allocate enough storage to hold the word, and store the address in the array of char pointers. 
 *     Then it should copy the word from the temporary array into the allocated storage. Thus, you wind 
 *     up with an array of character pointers, each pointing to an object of the precise size needed to 
 *     store the particular word. A sample run could look like this (user input in color):
 *
 *     How many words do you wish to enter? 5
 *     Enter 5 words now:
 *     I enjoyed doing this exercise
 *     Here are your words:
 *     I
 *     enjoyed
 *     doing
 *     this
 *     exercise
 *
 *     couldn't get "getline" to work right. did a forced input
 */
void question_18()
{
	printf("How many words do you wish to enter? ");
	int number_of_words;
	scanf("%d", &number_of_words);
	
	printf("Enter %d word(s) now: \nI want to win game\n", number_of_words);
	//char* buffer = malloc(128 * sizeof(*buffer));
	char* buffer = "I want to win game\n\0";
	size_t size = 128;
	//getline(&buffer, &size, stdin);

	char** list_of_words = malloc(16 * sizeof(*list_of_words));
	char** list_beginning = list_of_words;
	char* word = malloc(32 * sizeof(*word));
	char* beginning = word;
	
	printf("Here are your words.\n");
	while(*buffer)
	{
		if (*buffer == ' ' || *buffer == '\n') 
		{
			*word = '\0';
			while (beginning - word)
			{
				word--;
			}
			*list_of_words = word;
			printf("%s\n", *list_of_words);
			list_of_words++;
			buffer++;
		}
		else 
		{
			*word = *buffer;
			word++;
			buffer++;
		}
	}

}

/*
 * 19. What’s wrong with this template?
 *     
 *     structure {
 *     		char itable;
 *     		int  num[20];
 *     		char * togs
 *     	}
 *
 *     	structure should be "struct"
 *	char * togs needs a semicolon on the end.
 *
 * 20. Devise a structure type that will hold the name of a month, a three-letter abbreviation for 
 *     the month, the number of days in the month, and the month number.
 */
typedef struct months
{
	char month[10];
	char mon[3];
	int number_of_days;
	int month_number;	
} months_t;

void initMonths(months_t* m)
{
	char* names[12] = {"January", "February", "March", "April", "May", "June", 
		"July", "August", "September", "October", "November", "December"};
	char* abrevs[12] = {"Jan","Feb","Mar","Apr","May","Jun",
		"Jul","Aug","Sep","Oct","Nov","Dec"};
	int days[12] = {31, 28, 31, 30, 31, 30, 31, 30, 31, 31, 30, 31};

	for (int i = 0; i < 12; i++)
	{
		strcpy(m[i].month, names[i]);
		strcpy(m[i].mon, abrevs[i]);
		m[i].number_of_days = days[i];
		m[i].month_number = i+1;
	}
}

/*
 * 21. Write a function that, when given the month number, returns the total days(left???) in the year up 
 *     to and including that month. Assume that the structure type of question 20 and an appropriate 
 *     array of such structures are declared externally.
 */
int returnDaysLeft(months_t* m, int month_number)
{
	int daysLeft = 0;
	for (int i = month_number-1; i < 12; i++)
	{
		daysLeft += m[i].number_of_days;
	}
	return daysLeft;
}

/*
 * 22. a. Given the following typedef, declare a 10-element array of the indicated structure. Then, 
 *        using individual member assignment (or the string equivalent), let the third element 
 *        describe a Remarkatar lens with a focal length of 500 mm and an aperture of f/2.0.
 *        
 *        typedef struct lens {	     // lens descriptor //
 *        	float foclen;        // focal length,mm //
 *        	float fstop;         // aperture        //
 *        	char brand[30];      // brand name      //
 *        } LENS;
 *
 *     b. Repeat part a., but use an initialization list with a designated initializer in the 
 *        declaration rather than using separate assignment statements for each member.
 */
typedef struct lens 
{      			// lens descriptor //
	float foclen;   // focal length,mm //
	float fstop;    // aperture        //
	char brand[30]; // brand name      //
} LENS_t;
void initLens(LENS_t* l)
{
	// a
	l[0].foclen = 100;
	l[0].fstop = 8;
	strcpy(l[0].brand, "Nikon");
	l[1].foclen = 100;
	l[1].fstop = 8;
	strcpy(l[1].brand, "Nikon");
	l[2].foclen = 500;
	l[2].fstop = 2;
	strcpy(l[2].brand, "Remarkatar");
	l[3].foclen = 100;
	l[3].fstop = 8;
	strcpy(l[3].brand, "Nikon");
	l[4].foclen = 100;
	l[4].fstop = 8;
	strcpy(l[4].brand, "Nikon");
	l[5].foclen = 100;
	l[5].fstop = 8;
	strcpy(l[5].brand, "Nikon");
	l[6].foclen = 100;
	l[6].fstop = 8;
	strcpy(l[6].brand, "Nikon");
	l[7].foclen = 100;
	l[7].fstop = 8;
	strcpy(l[7].brand, "Nikon");
	l[8].foclen = 100;
	l[8].fstop = 8;
	strcpy(l[8].brand, "Nikon");
	l[9].foclen = 100;
	l[9].fstop = 8;
	strcpy(l[9].brand, "Nikon");

	// b
	/*
	l[0] = {100, 8, "Nikon"};
	l[1] = {100, 8, "Nikon"};
	l[2] = {500, 2, "Remarkatar"};
	l[3] = {100, 8, "Nikon"};
	l[4] = {100, 8, "Nikon"};
	l[5] = {100, 8, "Nikon"};
	l[6] = {100, 8, "Nikon"};
	l[7] = {100, 8, "Nikon"};
	l[8] = {100, 8, "Nikon"};
	l[9] = {100, 8, "Nikon"};
	*/
}

/*
 * 23. Consider the following programming fragment:
 * struct name {
 *     	char first[20];
 *     	char last[20];
 * };
 * struct bem {
 * 	int limbs;
 * 	struct name title;
 * 	char type[30];
 * };
 * struct bem * pb;
 * struct bem deb = {
 * 	6,
 * 	{"Berbnazel", "Gwolkapwolk"},
 * 	"Arcturan"
 * };
 *
 * pb = &deb;
 *     a. What would each of the following statements print?
 *   	  	printf("%d\n", deb.limbs);	// 6
 *   	  	printf("%s\n", pb->type);	// Arcturan
 *   	  	printf("%s\n", pb->type + 2);   // cturan
 *     	 
 *     b. How could you represent "Gwolkapwolk" in structure notation (two ways)?
 *        deb.title.last
 *        pb->title.last
 *
 *     c. Write a function that takes the address of a bem structure as its argument and prints 
 *        the contents of that structure in the form shown here (assume that the structure 
 *        template is in a file called starfolk.h):
 *
 *        Berbnazel Gwolkapwolk is a 6-limbed Arcturan.
 *        void contents(struct bem deb) 
 *        {
 *        	printf("%s %s is a %d-limbed %s", deb.title.first, deb.title.last, deb.limbs, deb.type);
 *        }
 */

/*
 * 24. Suppose you have this structure:
 * struct gas {
 * 	float distance;
 * 	float gals;
 * 	float mpg;
 * };
 * 	a. Devise a function that takes a struct gas argument. Assume that the passed structure contains 
 * 	   the distance and gals information. Have the function calculate the correct value for the mpg 
 * 	   member and return the now completed structure.
 *	   struct gas clac_mpg(struct gas g)
 *	   {
 *	   	g.mpg = g.distance / g.gals;
 *	   	return g;
 *	   }
 *
 * 	b. Devise a function that takes the address of a struct gas argument. Assume that the passed 
 * 	   structure contains the distance and gals information. Have the function calculate the correct 
 * 	   value for the mpg member and assign it to the appropriate member.
 *	   void calc_mpg(struct gas* g)
 *	   {
 *		g->mpg = g->distance / g->gals;
 *	   }
 * 	   
 */
/*
 * 25. Write a program that implements the following recipe:
 *     a. Externally define a name structure template with two members: a string to hold the first name 
 *        and a string to hold the second name.
 *
 *     b. Externally define a student structure type with three members: a name structure, a grade array 
 *        to hold three floating-point scores, and a variable to hold the average of those three scores.
 *
 *     c. Have the main() function declare an array of CSIZE (with CSIZE = 4) student structures and initialize 
 *        the name portions to names of your choice. Use functions to perform the tasks described 
 *        in parts d., e., f., and g.
 *
 *     d. Interactively acquire scores for each student by prompting the user with a student name and 
 *        a request for scores. Place the scores in the grade array portion of the appropriate structure. 
 *        The required looping can be done in main() or in the function, as you prefer.
 *
 *     e. Calculate the average score value for each structure and assign it to the proper member.
 *
 *     f. Print the information in each structure.
 *
 *     g. Print the class average for each of the numeric structure members.
 *
 *     Didn't get to this, ran outta time.
 */

/*
 * Main: where questions are ran and compiled.
 */
int main()
{
	// question 1
	question_1();

	// question 2
	double source[5] = {1.1, 2.2, 3.3, 4.4, 5.5};
	double target1[5];
	double target2[5];
	double target3[5];
	copy_arr(target1, source, 5);
	copy_ptr(target2, source, 5);
	copy_ptrs(target3, source, source+5);
	print_arr(target1, 5);
	print_arr(target2, 5);
	print_arr(target3, 5);

	// question 3
 	int question3[10] = {2, 6, 7, 1, 1, 4, 6, 9, 9, 4,};
	printf("the largest is %d.\n", largest(question3, LEN(question3)));	

	// question 4
 	double question4[10] = {2, 6, 7, 1, 1, 4, 6, 9, 9, 4};
	printf("the largest index is %d.\n", largestIndex(question4, LEN(question4)));	

	// question 5
 	double question5[10] = {2, 6, 7, 1, 1, 4, 6, 9, 9, 4};
	printf("the difference between the largest element and smallest element is %.1f.\n", difference(question5, LEN(question5)));	
	// question 6 
 	double question6[10] = {2, 6, 7, 1, 1, 4, 6, 9, 9, 4};
	printf("\nOriginal...\n");
	print_arr(question6, 10);
	reverseArray(question6, LEN(question6));
	printf("\nReversed...\n");
	print_arr(question6, 10);

	// question 7
	question_7();
	
	// question 8
	question_8();	

	// question 9
	question_9();	

	// question 10
	char* x = pr("Ho Ho Ho!");
	printf("\n%s\n", x);

	// question 11
	question_11();

	// question 12
	question_12();
	printf("\n");

	// question 13
	char* str1 = "Howdy\t there\t partner\n";
	char str2[10];
	printf("%s\n", str1);
	nfetch(str1, 10, str2);
	printf("%s\n", str2);

	// question 14
	char* question14 = "Hello";
	printf("%s\n", search_char(question14, 'l'));
	// returns null // printf("%s\n", search_char(question14, 'q'));

	// question 15
	char* question15 = "Hello";
	printf("%d\n", contains(question15, 'l'));
	printf("%d\n", contains(question14, 'q'));
	
	// question 16
	char str_1[11] = "beckingham";
	char str_2[7] = "hecking";
	printf("The new string from '%s' to '%s' in the first %d characters is '%s'.\n", 
			"hecking", "beckingham", 4, mystrncpy(str_1, str_2, 4));

	// question 17
	printf("The index of where '%s' starts in '%s' is %d.\n", "at", "cats", index_of("cats", "at"));
	printf("The index of where '%s' starts in '%s' is %d.\n", "atspult", "cats", index_of("cats", "atspult"));
	printf("The index of where '%s' starts in '%s' is %d.\n", "shrimpy", "mpy", index_of("shrimpy", "mpy"));

	// question 18
	question_18();	

	// question 20
	months_t months_in_a_year[12];
	initMonths(months_in_a_year);
	printf("%s\n", months_in_a_year[3].month);

	// question 21
	printf("%d\n", returnDaysLeft(months_in_a_year, 10));

	// question 22
	LENS_t lens[10];
	initLens(lens);	

	// question 25
	
	return 0;
}
