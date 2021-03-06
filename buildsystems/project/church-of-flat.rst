.. SPDX-FileCopyrightText: 2020 Dmytro Kolomoiets <amerlyq+rst@gmail.com> and contributors.

.. SPDX-License-Identifier: CC-BY-SA-4.0

.. highlight:: bash

.. Что ж, я давно не тренировался в евангелизме, пора тряхнуть стариной (надеюсь не отвалится).
.. Ведь здесь такая благодатная почва для новой потенциальной паствы в *Церковь Флэта*.
.. P.S. Надо чтобы просто закрался червячок сомнений, просто чтобы вы начали мучаться глядя на папку "<company>" и "осознали что потеряли" :D)))

.. Вначале успокою: не переживайте, у вас будет ваша папка "<company>" для доменов.
.. Потому можно попробовать объективно рассмотреть нижележащие аргументы:

##############
Church of Flat
##############

Лозунг
======

Примкните к рядам расшатывателей скреп мироздания!
Скажите нет привычному укладу вещей в структуре проекта::

   project
   ├── common
   ├── <company> (or "domains", or "src", or "package")
   ├── sdk
   ├── third-party (or "ext-deps")
   └── tools

Idea
----
Ваша папка "<company>" / "src" / "package" заполнена отдельными модулями/фичами -- но чем top-level содержимое "project" хуже?
Это тоже точно такая же фича -- не более чем композиция из клея изготовленного специально для данного проекта и размазанного по top-level.
А значит весь клей из "project" можно переместить в отдельную изолированную папочку внутри `src/project` и вызывать из главного Makefile.

Более того, тогда в одном "project" может безболезненно параллельно существовать
несколько альтернативных проектов -- постоянно или только на время апгрейда/миграции --
ведь они будут отличаться только клеем внутри их папок `src/project` и `src/project-v2`.

Но тогда... зачем вам папка "<company>" / "src" -- ведь наверху кроме неё *вообще ничего* не будет.
И потому все фичи/модули можно хранить напрямую на top-level в корне проекта.

Promo
-----
* Видео с презентацией, где я сравниваю кучу разных способов организовать файлы проектов в папки и топлю за плоский способ `feature-type`
    + `Build systems - Project structure principles - flat.mp4`


(0) Проекты почитателей «плоского мира»
=======================================

TBD: Impossible to google, must look through projects sources one by one...

FOSS-flat
---------

* https://github.com/pocoproject/poco
* ... (TBD, added as found)

Proprietary-flat
----------------

* hmc2
* ... (TBD, added when remembered)

FOSS-semiflat (they still have "<company>" dir)
-----------------------------------------------

* ports: https://github.com/microsoft/vcpkg
* package: https://github.com/buildroot/buildroot
* ...


(1) Сущность "<company>" -- не существует
=========================================

INFO
----
* 97 Things Every Software Architect Should Know - Free Computer, Programming, Mathematics, Technical Books, Lecture Notes and Tutorials ⌇⡞⢅⢊⡲
    + http://freecomputerbooks.com/97-Things-Every-Software-Architect-Should-Know.html

ARCH
----
У папки "<company>" выше нет архитектурных или организационных причин к существованию:

* Папка "<company>" или "domains" -- это некорректное название, потому что все папки на всех уровнях -- это условно домены компании, и мы владеем ~всем~ данным продуктом.
* Даже "third-party" это домен компании! Потому что структура проекта -- это тоже продукт интеллектуальной собственности, отдельный от собственности кода (см. лицензии на схемы баз данных).
* Тоесть папка "<company>" это только часть от всех папок, !огрызок от фичи!, и потому корректного названия для него *не существует* -- у этой папки нет "one responsibility".
* Согласно архитектурным принципам, сущностей не имеющих истоков в *домене проблемы*, не являющихся "необходимым клеем", и в то же время с неопределённой целью существования -- стоит избегать.

::

   company_root
   ├── <company>
   │   ├── domain-A
   │   └── domain-B
   ├── sdk
   └── third-party


(2) Психологическое сопротивление
=================================

INFO
----
* Список когнитивных искажений — Википедия ⌇⡞⢅⢈⢵
    + https://ru.wikipedia.org/wiki/Список_когнитивных_искажений

VIZ
---
Наличие папки "<company>" успокаивает, а отсутствие вызывает сопротивление в силу когнитивных искажений:

* Инертность мышления ко всему новому, неизвестному, и непривычному -- всему что требует внутренних изменений и затрат энергии.
* Ментальная склонность "всё категоризировать": искать паттерны и структуры даже там где их нет.
* Синдром истинности: раскладывание "истинным (привычным) способом" всего того, что можно на самом деле разложить множеством эквивалентных способов.
* Избирательное восприятие = "зашоривание" обзора и искажение акцентов: наличие структуры кажется оправданным даже там, где её наличие -- заблуждение (или даже приносит вред).
* ... (плюс ещё с десяток когнитивных искажений, на которые стоит смотреть объективно и со стороны)


(3) Структурные границы, приватность, и чувство собственности:
==============================================================

INFO
----
* How Proper Task Flow Can Help You Avoid Collaboration Collapse - Flow ⌇⡞⢅⢈⣐
    + https://www.getflow.com/blog/collaboration-collapse
* Flat Will Kill You, Eventually: Why Every Company Needs… - Flow ⌇⡞⢅⢈⣔
    + https://www.getflow.com/blog/flat-will-kill-you

ARG
---
* Домен -- это не проект. Проект -- это прошивка, "root". То «целое», которое приносит деньги.
* Это наш общий проект как части компании -- и от его успеха *как целого* зависит индивидуальный успех доменов. Не наоборот.
* Мы не разрабатываем "свой отдельный проектик внутри проекта", изолированный от всего остального -- нет, мы улучшаем связное "целое".
* Но людям нужны "шторки" -- как для сохранения приватности и свободы экспериментов, так и для поддержания социальных групп.
* Потому границы между доменами -- важны как для команд, так и для индивидов. И важны именно потому, что они *мешают* прозрачности и замедляют коммуникацию.
* Более того, "чувство собственности", а из него и "персональной заинтересованности" -- невозможны без наличия чётких "уютных" **границ**.
* Структурные границы совпадающие с границами интерфейсов -- создают **ниши** для накопления экспертизы и локализуют хаос.
* Произвольно введённые границы -- создают **барьеры** в прозрачности, коммуникации, и чувстве собственности.
* Последнее десятилетие на слуху фраза, что структура коммуникаций внутри компании влияет на архитектуру проекта, подгоняя потоки данных внутри кода под внешнюю коммуникацию менеджеров.
* Но! Верно и обратное: структура проекта влияет на коммуникацию между людьми и на то, что они готовы и не готовы делать (через восприятие, форму мышления и внутренние домыслы).
* Итого папка "<company>" это именно такой произвольный барьер, причиняющий реальный ущерб, во имя сохранения "привычного" уклада вещей, и совершенно не компенсирующийся самоценностью искусственно созданной ниши.


(4) Архитектура прошивки
========================

INFO
----
* Robert C Martin - Clean Architecture and Design - YouTube ⌇⡞⢅⢉⢇
    + https://www.youtube.com/watch?v=Nsjsiz2A9mg

ARCH
----
* Архитектура -- это "намерение" проекта, которое нам доносит его структура.
* И это намерение необходимо видеть сразу, как только ты открываешь папку проекта.
* Намерение кодовой базы проекта *прошивки* -- это композиция взаимодействующих компонент.
* Акцент не на потоках данных (это рантайм), не на зонах ответственности (это организация), не на периметре безопасности (это секьюрити, но с ним сложнее), не на поставщиках и потребителях компонент (это воркфлоу), а именно на том, как сделать саму *прошивку*.
* Взаимодействие компонент в рантайме может быть (и является) ужасно сложным (и *всегда* содержащим баги) динамическим графом, который описан самим кодом и размазан по всем компонентам.
* Но создание *прошивки* -- это просто композиция "условно независимых" компонент (в порядке обусловленном их графом)

Так о чём нам говорит дополнительный уровень вложенности для папок в данном случае (см. ниже), когда мы впервые открываем корень проекта?
-- О том что проект прошивки `usual_root` состоит из четырёх **компонент** (`<company>, foss, sdk, third-party`),
каждая из которых разрабатывается кем-то «как единое целое» (и потому глубже лезть не стоит).
Но ирония в том, что ни одна из этих верхнеуровневых папок -- не является компонентой.
И даже в структуре организации нигде не существует ни одной сущности, которая бы соответствовала этим папкам!

А какие выводы делает разработчик домена, когда ему показывают глубоко спрятанную папку команды "domain-A" и говорят что в ней есть всё что нужно?
-- Что все остальные папки -- это папки хаоса и неизвестности, в которых (на уровне подсознания) что-то менять *запрещено* и даже просто заглядывать в них *осуждается*.

::

   usual_root
   ├── <company>
   │   ├── domain-A
   │   └── domain-B
   ├── foss
   │   ├── lib-A
   │   └── lib-B
   ├── sdk
   │   ├── boot
   │   ├── buildroot
   │   ├── linux
   │   └── toolchain
   └── third-party
       ├── vendor-A
       │   └── dep-A1
       └── vendor-B
           ├── dep-B1
           └── dep-B2



(5) Граф зависимостей
=====================

INFO
----
* Graph File Systems – A File Systems Geek ⌇⡞⢅⢝⣋
    + https://fsgeek.ca/2019/05/09/graph-file-systems/

IMPL
----
* Любой проект это лишь набор фич, их композиция. И прошивка как проект -- это тоже лишь набор фич.
* Любой *набор* чего либо -- это тоже фича (структурная), и она *всегда* содержит что-то уникальное для неё.
* Минимальный блок переиспользования фич -- это модуль: кусок кода, имеющий название в домене проблемы,
  который можно полностью понять за один день. Желательно с конфигами и доками, и в отдельной папке.
* Фичи зависят на фичи. Не на домены как целое, а именно на их отдельные фичи!
* Все фичи составляют ациклический граф, а не модульное дерево. И отображений графа на файловую систему всего два, это:
    #) линейный список с конфигами связей (просто, однообразно, понятно, переносимо).
    #) линейный список с симлинками на зависимые компоненты (прозрачно, но тяжелее мейнтейнить и проблемы поддержки на винде).
* Не даром ведь список *пакетов* в дистрибутивах или языках -- это плоские списки. Как и список библиотек в /usr/lib.

Однаком здесь есть ровно одна граница "ext-deps" которая отделяет "ваш" код проекта от "чужого" кода зависимостей.
Фактически она создаёт один неделимый модуль/фичу "ext-deps", с которой вы всегда работаете как с единым целым.
И эта граница присутствует во всех воркфлоу на всех уровнях: от порядка сборки в билдсистеме до квартальной денежной отчётности.

::

   flat_root
   ├── boot
   ├── buildroot
   ├── domain-A
   ├── domain-B
   ├── ext-deps
   │   ├── dep-A1
   │   ├── dep-B1
   │   ├── dep-B2
   │   ├── lib-A
   │   └── lib-B
   ├── linux
   ├── sdk
   └── toolchain


(6) Эволюция разрушает форму
============================

INFO
----
* Foreword to Building Evolutionary Architectures ⌇⡞⢅⢟⡃
    + https://martinfowler.com/articles/evo-arch-forward.html

ARCH
----
* Эволюционирующий программный проект -- это "moving target".
* Любые попытки заранее *искусственно* сгруппировать модули обречены на провал -- их взаимоотношения сильно меняются со временем.
* Плоская структура позволяет *отложить* все решения по структурной организации «на потом»
* «Потом», конечно же, никогда не наступит -- так как кодовая база постоянно меняется, проекты перетекают друг в друга и произвольные наборы модулей переиспльзуются в других проектах.
* Потому группировка модулей вначале -- мешает переиспользованию и рефакторингу (из-за лишних барьеров), а потом -- просто бессмысленна.


(7) Инфраструктура, инструменты, мейнтенанс и лучшие практики
=============================================================

* Git submodules -- лучше всего держать все на верхнем уровне, а не в подпапках
* Nested git submodules -- в тенденции последних пяти лет не лучшая практика
* ... (TBD, too lazy to enumerate now)


(8) Симлинки, теги и *relations*
================================

INFO
----
* Extended attributes and tag file systems ⌇⡞⢅⢗⣎
    + https://www.lesbonscomptes.com/pages/tagfs.html
* TagFS, tracking progress in the field of semantic file systems • Linux goesZen ⌇⡞⢅⢗⡼
    + https://linux.goeszen.com/tagfs-tracking-progress-in-the-field-of-semantic-file-systems.html

EXPL
----
Если очень хочется группировать -- то можно создать специальную папку `arch-tags` поверх `flat_root`.
Каждый тег в `arch-tags` позволяет группировать по одному признаку (*relations*).
Принадлежность к группе, общая модель коммуникации, reverse-dependencies по компонентам, итп.
Вплоть до тегов `good, bad, ugly, todo, split`.
Огромное раздолье для "exploration navigation" для мятежной души.

(Disclaimer: в репозитории airy_ на 250 компонент я автоматически создаю подобное дерево тегов.
Но за пять лет -- я им ни разу не воспользовался. Плоского списка в корне всегда хватает
для решения любых задач -- как изолированных так и для *каждый раз уникальных* наборов компонент.)

.. _airy: https://github.com/amerlyq/airy

::

   flat_root
   ├── arch-tags
   │   ├── <company>
   │   │   ├── domain-A     → ../../domain-A
   │   │   └── domain-B     → ../../domain-B
   │   ├── foss
   │   │   ├── lib-A        → ../../ext-deps/lib-A
   │   │   └── lib-B        → ../../ext-deps/lib-B
   │   ├── sdk
   │   │   ├── boot         → ../../boot
   │   │   ├── buildroot    → ../../buildroot
   │   │   ├── ctl          → ../../sdk
   │   │   ├── linux        → ../../linux
   │   │   └── toolchain    → ../../toolchain
   │   ├── third-party
   │   │   ├── foss         → ../foss
   │   │   ├── vendor-A     → ../vendor-A
   │   │   └── vendor-B     → ../vendor-B
   │   ├── vendor-A
   │   │   └── dep-A1       → ../../ext-deps/dep-A1
   │   └── vendor-B
   │       ├── dep-B1       → ../../ext-deps/dep-B1
   │       └── dep-B2       → ../../ext-deps/dep-B2
   ├── boot
   ├── buildroot
   ├── domain-A
   ├── domain-B
   ├── ext-deps
   │   ├── dep-A1
   │   ├── dep-B1
   │   ├── dep-B2
   │   ├── lib-A
   │   └── lib-B
   ├── linux
   ├── sdk
   └── toolchain
