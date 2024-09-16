# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jocuni-p <jocuni-p@student.42barcel>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/05 16:15:05 by jocuni-p          #+#    #+#              #
#    Updated: 2023/06/28 12:39:06 by jocuni-p         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#---------------------VARIABLES-----------------------#
CC = cc
CFLAGS = -Wall -Werror -Wextra

#nom del programa-binari que crearem
NAME = libft.a

#'ar' es una utilitat per crear i mantenir grups d'arxius combinats en un sol
#arxiu i l'usarem  per crear la llibreria
#'r' la reeemplasara si existeix ja i la creara si no existeix
#'c' fa que es silencii el missatge de la creacio de ar
#'s' escriu un index d'arxius objecte a dins per el seu control intern
LIB = ar -rcs

#arxius source que utilitzarem per crear el programa
#no inclou el .h perque el llegeix sense compilar-lo
SRC = ft_isalpha.c ft_isdigit.c ft_isalnum.c ft_isascii.c ft_isprint.c\
	  ft_strlen.c ft_tolower.c ft_toupper.c ft_strchr.c ft_strrchr.c\
	  ft_strncmp.c ft_atoi.c ft_memset.c ft_bzero.c ft_memchr.c\
	  ft_memcpy.c ft_memcmp.c ft_memmove.c ft_strlcpy.c ft_strnstr.c\
	  ft_calloc.c ft_strdup.c ft_strlcat.c ft_substr.c ft_strjoin.c\
	  ft_strtrim.c ft_split.c ft_itoa.c ft_strmapi.c ft_striteri.c\
	  ft_putchar_fd.c ft_putstr_fd.c ft_putendl_fd.c ft_putnbr_fd.c\
	  ft_putnbr_fd.c

SRC_BONUS = ft_lstnew_bonus.c ft_lstadd_front_bonus.c ft_lstsize_bonus.c\
			ft_lstlast_bonus.c ft_lstadd_back_bonus.c ft_lstdelone_bonus.c\
			ft_lstclear_bonus.c ft_lstiter_bonus.c ft_lstmap_bonus.c

#aqui detallem nom dels objects
#genera una llista de noms d'arxius .o a partir de la lista de noms .c
OBJ = $(SRC:.c=.o)

OBJ_BONUS = $(SRC_BONUS:.c=.o)

#-------------------------RULES-----------------------#
#al fer make la primera regla que trova es la que executa, sino s'especifica
#una altre
all: $(NAME)

norm: 
	norminette

bonus: .bonus

$(NAME): $(OBJ)
	$(LIB) $(NAME) $(OBJ)

#usem 'ar' per crear una llibreria
#si volguessim crear un programa seria 	$(CC) $(CFLAGS) $(OBJ) -o $(NAME)

.bonus: $(OBJ) $(OBJ_BONUS)
	$(LIB) $(NAME) $(OBJ) $(OBJ_BONUS)
	@touch .bonus
	

#crea els .o a partir dels .c i de la libft.h
%.o : %.c libft.h Makefile
	$(CC) -c $(CFLAGS) $< -o $@
#amb cc crea els arxius de codi objecte (-c).
#La var automatica $< agafa el nom del .c (src) i $@ el dona al .o (target)


#elimina els arxius creats .o i els .bonus
clean:
	rm -f *.o .bonus
# amb -f ignorem els arxius que no existeixen, borrats ja previament

#fa 'clean' i elimina el binary executable
fclean: clean
	rm -f $(NAME)

#fa un 'make clean' seguit d'un 'make all'
re: fclean all

rebonus: fclean bonus


#amb el PHONY TARGET (falso objetivo) avisem al make que aquests no son arxius
#que hagi de generar sino instruccions/reglas
.PHONY: clean fclean re all bonus
