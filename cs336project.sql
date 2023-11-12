
create table if not exists users(
	username varchar(50), 
	pswd varchar(50), 
	isAdmin boolean,  
	customerRep boolean,
	primary key(username));

create table if not exists vehicles (
	vid int not null AUTO_INCREMENT,
    itemName varchar(50),
    minPrice double,
    primary key(vid),
    power int,              # assign if motorbike
    country varchar(50),    # assign if foreign car
    container boolean       # assign if truck
);

create table if not exists auction (
	aid int not null AUTO_INCREMENT,
	available boolean,
	username varchar(50),
    vid int,
    endTime date,
    winner varchar(50),
    curBid double,
	primary key(aid),
	foreign key (username) references users(username) on delete cascade on update cascade,
    foreign key (vid) references vehicles(vid) on delete cascade on update cascade,
    foreign key (winner) references users(username) on delete set null on update cascade
);

create table if not exists bid (
	aid int,
    username varchar(50),
	amount double,
    primary key(aid, username, amount),
    increment double,    # assign if auto bid
    upperLim double,     # assign if auto bid
    foreign key(aid) references auction(aid) on delete cascade on update cascade,
    foreign key(username) references users(username) on delete cascade on update cascade
);

create table if not exists QA (
	qid int not null AUTO_INCREMENT,
	ques varchar(2000),
    ans varchar(2000),
    primary key (qid)
);

#data tests
insert into users (username, pswd, isAdmin, customerRep) values ('admin','admin', true, false);
insert into users (username, pswd, isAdmin, customerRep) values ('cusRep', 'cusRep', false, true);
insert into users (username, pswd, isAdmin, customerRep) values ('user1', 'user1', false, false);
insert into users (username, pswd, isAdmin, customerRep) values ('user2', 'user2', false, false);
insert into users (username, pswd, isAdmin, customerRep) values ('user3', 'user3', false, false);
insert into users (username, pswd, isAdmin, customerRep) values ('user4', 'user4', false, false);
#User 5 for signup functionality, sells, bid (2nd auction)
insert into vehicles (vid, itemname, minprice) values (1, 'Car1', 100);
insert into vehicles (vid, itemname, minprice, power) values (2, 'motorbike',100 , 500);
insert into vehicles (vid, itemname, minprice, container) values (3, 'truck', 100, true);
#Show enter/sell vehicle and auction that vehicle 
insert into auction (available, username, vid, endtime, winner, curBid) values (true, 'user1', 1, DATE('2022-04-15'), 'user2', 200);
insert into auction (available, username, vid, endtime, winner, curBid) values (true, 'user1', 2, DATE('2022-05-20'), 'user1', 400);

insert into bid (aid, username, amount) values (1, 'user2', 200);
insert into bid (aid, username, amount) values (1, 'user3', 120);
insert into bid (aid, username, amount) values (2, 'user1', 400);
insert into bid (aid, username, amount) values (2, 'user4', 250);


insert into QA (ques) values ("How do I bid?");
update QA set ans='Click on the bid now button and type in the corresponding data' where qid=1;
insert into QA (ques) values ("Where will I be notified that I won an auction?");
update QA set ans='Users will be notified after they login if they won an auction' where qid=2;
insert into QA (ques) values ("How do I access my bid history>");
insert into QA (ques) values ("Can I see and auction the same vehicle?");