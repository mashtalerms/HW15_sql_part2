create table breeds(
    id integer primary key autoincrement,
    breed varchar(100)
);


insert into breeds(breed)
select distinct * from(
    select distinct
        breed
    from animals
   );


create table outcome(
    id integer primary key autoincrement,
    subtype varchar(100),
    `type` varchar(100),
    `month` integer,
    `year` integer
);


insert into outcome (subtype, `type`, `month`, `year`)
select distinct animals.outcome_subtype,
                animals.outcome_type,
                animals.outcome_month,
                animals.outcome_year
from animals;


create table colors(
    id integer primary key autoincrement,
    color varchar(100)
);


insert into colors(color)
select distinct * from(
    select distinct
        color1 as color
    from animals
    union all
    select distinct
        color2 as color
    from animals
   );


create table new_animals(
    id integer primary key autoincrement,
    age_upon_outcome varchar(100),
    animal_id varchar(100),
    animal_type varchar(100),
    name varchar(100),
    breed_id integer,
    date_of_birth varchar(100),
    outcome_id integer,
    foreign key (outcome_id) references outcome(id),
    foreign key (breed_id) references breeds(id)
);


create table animals_breeds(
    animals_id integer,
    breed_id integer,
    foreign key (animals_id) references new_animals(id),
    foreign key (breed_id) references breeds(id));


insert into animals_breeds(animals_id, breed_id)
select distinct new_animals.id, breeds.id
from animals
join breeds on breeds.breed = animals.breed
join new_animals on new_animals.animal_id = animals.animal_id;


create table animals_colors(
    animals_id integer,
    colors_id integer,
    foreign key (animals_id) references new_animals(id),
    foreign key (colors_id) references colors(id)
);


insert into animals_colors(animals_id, colors_id)
select distinct new_animals.id, colors.id
from animals
join colors on colors.color = animals.color1
join new_animals on new_animals.animal_id = animals.animal_id
union all
select distinct new_animals.id, colors.id
from animals
join colors on colors.color = animals.color2
join new_animals on new_animals.animal_id = animals.animal_id
;


insert into new_animals (age_upon_outcome, animal_id, animal_type, name, date_of_birth,breed_id, outcome_id)
select distinct animals.age_upon_outcome,
                animals.animal_id,
                animals.animal_type,
                animals.name,
                animals.date_of_birth,
                breeds.id,
                outcome.id
from animals
join breeds on breeds.breed = animals.breed
join outcome
    on outcome.subtype = animals.outcome_subtype
    and outcome.type = animals.outcome_type
    and outcome.month = animals.outcome_month
    and outcome.year= animals.outcome_year
;


--Убираем лишние пробелы

update animals
set breed = trim(breed),
    color1 = trim(color1),
    color2 = trim(color2),
    outcome_subtype = trim(outcome_subtype),
    outcome_type = trim(outcome_type),
    animal_type = trim(animal_type);
