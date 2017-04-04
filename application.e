note
	description: "lab application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	new_out: PLAIN_TEXT_FILE

	make
			-- Run application.
		do
			create new_out.make_create_read_write ("out.txt")
			io.set_file_default (new_out)

--			test_biologist_id (1)
--			test_biologist_name ("Name")
--			test_biologist_discipline
--			test_cs_discipline
--			test_bioinformatics_discipline
--			test_inheritance
--			test_biologist_pet_name ("Teddy")
--			test_bio_informatics_short_bio ("test_bio")
--			test_lab

			io.set_output_default
			io.read_character
		end

	test_biologist_id (id: NATURAL)
		local
			biologist: BIOLOGIST
		do
			new_out.open_write
			create biologist
			biologist.id := id
			biologist.introduce
			new_out.close
			new_out.open_read
			new_out.read_line
			check
				new_out.last_string.is_equal ("Id: " + id.out)
			end
			new_out.close
		end

	test_biologist_name (name: STRING)
		local
			biologist: BIOLOGIST
		do
			new_out.open_write
			create biologist
			biologist.name := name
			biologist.introduce
			new_out.close
			new_out.open_read
			new_out.read_line
			new_out.read_line
			check
				new_out.last_string.is_equal ("Name: " + name)
			end
			new_out.close
		end

	test_biologist_discipline
		local
			biologist: BIOLOGIST
		do
			new_out.open_write
			create biologist
			biologist.introduce
			new_out.close
			new_out.open_read
			new_out.read_line
			new_out.read_line
			check
				new_out.last_string.is_equal ("Discipline: biologist")
			end
			new_out.close
		end

	test_cs_discipline
		local
			computer_scientist: COMPUTER_SCIENTIST
		do
			new_out.open_write
			create computer_scientist
			computer_scientist.introduce
			new_out.close
			new_out.open_read
			new_out.read_line
			new_out.read_line
			check
				new_out.last_string.is_equal ("Discipline: computer science")
			end
			new_out.close
		end

	test_bioinformatics_discipline
		local
			bio_informatics: BIO_INFORMATICS
		do
			new_out.open_write
			create bio_informatics
			bio_informatics.introduce
			new_out.close
			new_out.open_read
			new_out.read_line
			new_out.read_line
			check
				new_out.last_string.is_equal ("Discipline: bioinformatics")
			end
			new_out.close
		end

	test_inheritance
		local
			scientist: SCIENTIST
		  biologist: BIOLOGIST
		  computer_scientist: COMPUTER_SCIENTIST
		do
			create {BIOLOGIST} scientist
			create {COMPUTER_SCIENTIST} scientist
			create {BIO_INFORMATICS} biologist
			create {BIO_INFORMATICS} computer_scientist
		end

	test_biologist_pet_name (pet_name: STRING)
		local
			biologist: BIOLOGIST
			pet: PET
		do
			new_out.open_write
			create biologist
			create pet
			pet.name := pet_name
			biologist.pet := pet
			biologist.introduce
			new_out.close
			new_out.open_read
			new_out.read_line
			new_out.read_line
			new_out.read_line
			check
				new_out.last_string.is_equal ("Pet name: " + pet_name)
			end
			new_out.close
		end

	test_bio_informatics_short_bio (short_bio: STRING)
		local
			bio_informatics: BIO_INFORMATICS
		do
			new_out.open_write
			create bio_informatics
			bio_informatics.short_biography := short_bio
			bio_informatics.introduce
			new_out.close
			new_out.open_read
			new_out.read_line
			new_out.read_line
			new_out.read_line
			check
				new_out.last_string.is_equal ("Short bio: " + short_bio)
			end
			new_out.close
		end

	test_lab
		local
		  lab: LAB
			scientist: SCIENTIST
		do
			new_out.open_write
		  create lab
			create {COMPUTER_SCIENTIST} scientist
			lab.add_member (scientist)

			create {BIO_INFORMATICS} scientist
			scientist.id := 10
			lab.add_member (scientist)

			create {BIOLOGIST} scientist
			scientist.id := 5
			lab.remove_member (scientist)


			lab.introduce_all
			new_out.close
			new_out.open_read
			new_out.read_line
			check
				new_out.last_string.is_equal ("Id: 0")
			end

			new_out.read_line
			new_out.read_line
			check
				new_out.last_string.is_equal ("Id: 10")
			end
			new_out.close

		end

end
