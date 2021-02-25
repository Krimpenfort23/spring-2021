/**
 * Author:	Evan Krimpenfort
 *
 * Project:	Recreating the c function wc in our own code. Must include the parameters
 * 		-l, -w, and -m. Each parameter has a number code.
 * 			-l is 1
 * 			-w is 2
 * 			-m is 3
 * 			-lw is 4
 * 			-lm is 5
 * 			-wm is 6
 * 			-lwm is 8
 * 		if no parameters, then 0 includes all of them.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_INPUT 1000
#define OPTION_SIZE 8
#define MAX_INPUTS 4
#define L 1
#define W 2
#define M 3
#define LW 4
#define LM 5
#define WM 6
#define LWM 8
#define NONE 0

/**
 * @params *user_inputs
 *
 * @return int
 */
int analyze_inputs_per_line(const char* user_inputs)
{
	int lines = 0;
	char* copy = malloc(strlen(user_inputs) + 1);
	strcpy(copy, user_inputs);
	char* token = strtok(copy, "\n");
	while (token != NULL)
	{
		lines++;
		token = strtok(NULL, "\n");
	}

	free(copy);
	return lines;
}

/**
 * @params *user_inputs
 *
 * @return int
 */
int analyze_inputs_per_word(const char* user_inputs)
{
	int words = 0;
	char* copy = malloc(strlen(user_inputs) + 1);
	strcpy(copy, user_inputs);
	char* token = strtok(copy, " =.!?,;\n");
	while (token != NULL)
	{
		words++;
		token = strtok(NULL, " =.!?,;\n");
	}

	free(copy);
	return words;
}

/**
 * @params *user_inputs
 *
 * @return int
 */
int analyze_inputs_per_char(const char* user_inputs)
{
	int chars = 0;
	while (*user_inputs)
	{
		chars++;
		user_inputs++;
	}
	return chars;
}

/**
 * @params *user_inputs
 * @params parameters
 */
void switch_parameters(const char* user_inputs, int parameters)
{
	int lines = 0;
	int words = 0;
	int chars = 0;

	switch (parameters)
	{
		case L:
			lines = analyze_inputs_per_line(user_inputs);
			printf("%d\n", lines);
			break;
		case W:
			words = analyze_inputs_per_word(user_inputs);
			printf("%d\n", words);
			break;
		case M:
			chars = analyze_inputs_per_char(user_inputs);
			printf("%d\n", chars);
			break;
		case LW:
			lines = analyze_inputs_per_line(user_inputs);
			words = analyze_inputs_per_word(user_inputs);
			printf("\t%d\t%d\n", lines, words);
			break;
		case LM:
			chars = analyze_inputs_per_char(user_inputs);
			lines = analyze_inputs_per_line(user_inputs);
			printf("\t%d\t%d\n", lines, chars);
			break;
		case WM:
			chars = analyze_inputs_per_char(user_inputs);
			words = analyze_inputs_per_word(user_inputs);
			printf("\t%d\t%d\n", words, chars);
			break;
		case LWM:
			chars = analyze_inputs_per_char(user_inputs);
			words = analyze_inputs_per_word(user_inputs);
			lines = analyze_inputs_per_line(user_inputs);
			printf("\t%d\t%d\t%d\n", lines, words, chars);
			break;
		case NONE:
		default:
			chars = analyze_inputs_per_char(user_inputs);
			words = analyze_inputs_per_word(user_inputs);
			lines = analyze_inputs_per_line(user_inputs);
			printf("\t%d\t%d\t%d\n", lines, words, chars);
			break;
	}
}

/**
 * @params argc
 * @params **argv
 *
 * @return int
 */
int main(int argc, char** argv)
{
	int parameters = -1;
	char* user_input = malloc(MAX_INPUT * sizeof(*user_input));
	char* user_input_total = malloc(MAX_INPUT * sizeof(*user_input_total));
	char* option = malloc(OPTION_SIZE * sizeof(*option));

	/* if too many options */
	if (argc > MAX_INPUTS)
	{
		fprintf(stderr, "Usage: [-l] [-w] [-m]\n"); exit(1);
	}
	/* if no options presented */
	else if(argc == 1)
	{
		while (1)
		{
			if (fgets(user_input, MAX_INPUT, stdin) == NULL) { break; }
			strcat(user_input_total, user_input);
		}
		switch_parameters(user_input_total, NONE);
	}
	/* if options are presented */
	else
	{
		char* beginning = option;
		while (*++argv)
		{
			strcpy(option, *argv);
			while (*++option)
			{
				parameters++;
				if (*option == 'l') { parameters += 1; }
				else if (*option == 'w') { parameters += 2; }
				else if (*option == 'm') { parameters += 3; }
				else { fprintf(stderr, "Usage: [-l] [-w] [-m]\n"); exit(1); }
			}
		}
		option = beginning;

		while (1) 
		{ 
			if (fgets(user_input, MAX_INPUT, stdin) == NULL) { break; } 
			strcat(user_input_total, user_input);
		}
		switch_parameters(user_input_total, parameters);
	}
	
	free(option);
	free(user_input);
	free(user_input_total);
	return 0;
}
