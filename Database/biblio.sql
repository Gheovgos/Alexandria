PGDMP     '                    {           bibliografia    15.1    15.1 :    E           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            F           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            G           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            H           1262    17265    bibliografia    DATABASE        CREATE DATABASE bibliografia WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';
    DROP DATABASE bibliografia;
                postgres    false            U           1247    17267 	   tipo_enum    TYPE     x   CREATE TYPE public.tipo_enum AS ENUM (
    'Conferenza',
    'Libro',
    'Rivista',
    'Fascicolo',
    'Articolo'
);
    DROP TYPE public.tipo_enum;
       public          postgres    false            �           2605    17387 ,   CAST (public.tipo_enum AS character varying)    CAST     L   CREATE CAST (public.tipo_enum AS character varying) WITH INOUT AS IMPLICIT;
 3   DROP CAST (public.tipo_enum AS character varying);
                   false    853            7           2605    17386 ,   CAST (character varying AS public.tipo_enum)    CAST     L   CREATE CAST (character varying AS public.tipo_enum) WITH INOUT AS IMPLICIT;
 3   DROP CAST (character varying AS public.tipo_enum);
                   false    853            �            1255    17277    articolo_check()    FUNCTION     �   CREATE FUNCTION public.articolo_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Articolo' AND (NEW.ISBN IS NOT NULL OR NEW.DOI IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.articolo_check();
       public          postgres    false            �            1255    17278    conferenza_check()    FUNCTION     �  CREATE FUNCTION public.conferenza_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Conferenza' AND (NEW.ISNN IS NOT NULL OR NEW.ISBN IS NOT NULL OR NEW.Pag_Inizio IS NOT NULL OR NEW.Pag_Fine IS NOT NULL OR NEW.DOI IS NOT NULL
OR NEW.Edizione IS NOT NULL OR NEW.Editore IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.conferenza_check();
       public          postgres    false            �            1255    17279    fascicolo_check()    FUNCTION     /  CREATE FUNCTION public.fascicolo_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Fascicolo' AND (NEW.ISBN IS NOT NULL OR NEW.Editore IS NOT NULL OR NEW.Edizione IS NOT NULL OR NEW.ISNN IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 (   DROP FUNCTION public.fascicolo_check();
       public          postgres    false            �            1255    17280    libro_check()    FUNCTION     �   CREATE FUNCTION public.libro_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Libro' AND NEW.DOI IS NOT NULL THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 $   DROP FUNCTION public.libro_check();
       public          postgres    false            �            1255    17281    online_check()    FUNCTION     �   CREATE FUNCTION public.online_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.On_line = false AND NEW.URL IS NOT NULL THEN
	RAISE EXCEPTION 'Non puoi inserire un URL se il riferimento è offline';
END IF;
RETURN NEW;
END;
$$;
 %   DROP FUNCTION public.online_check();
       public          postgres    false            �            1255    17282    rivista_check()    FUNCTION     �   CREATE FUNCTION public.rivista_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Rivista' AND NEW.DOI IS NOT NULL THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 &   DROP FUNCTION public.rivista_check();
       public          postgres    false            �            1255    17395    sub_cat(integer)    FUNCTION     �  CREATE FUNCTION public.sub_cat(catin integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$

DECLARE
codice integer;
codiciString VARCHAR(100) := '';
catTmp integer := catIn;
i record;
BEGIN
FOR codice IN SELECT id_categoria FROM CATEGORIA WHERE super_categoria_id_categoria = catIn LOOP
RETURN NEXT codice;
RETURN QUERY SELECT sub_cat FROM sub_cat(codice);
END LOOP;
RETURN;
END;
$$;
 -   DROP FUNCTION public.sub_cat(catin integer);
       public          postgres    false            �            1255    17388    super_cat(integer)    FUNCTION     �  CREATE FUNCTION public.super_cat(catin integer) RETURNS TABLE(codice integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
arrayID integer[];
codiciString VARCHAR(100) := '';
catTmp integer := catIn;
supercatTmp integer := (SELECT super_categoria_id_categoria FROM Categoria WHERE id_categoria = catTmp);
BEGIN
WHILE supercatTmp IS NOT NULL
BEGIN LOOP
	arrayID := array_append(arrayID, supercatTmp);
	catTmp := supercatTmp;
	supercatTmp := (SELECT super_categoria_id_categoria FROM Categoria WHERE ID_Categoria = catTmp);
END LOOP;
IF array_length(arrayID, 1) IS NOT NULL THEN
FOREACH codice IN ARRAY arrayID LOOP
RETURN NEXT;
END LOOP;
END IF;
RETURN;
END;
$$;
 /   DROP FUNCTION public.super_cat(catin integer);
       public          postgres    false            �            1259    17290 	   categoria    TABLE     �   CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    descr_categoria character varying(500) NOT NULL,
    super_categoria_id_categoria integer,
    user_id integer
);
    DROP TABLE public.categoria;
       public         heap    postgres    false            �            1259    17295    categoria_id_categoria_seq    SEQUENCE     �   ALTER TABLE public.categoria ALTER COLUMN id_categoria ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.categoria_id_categoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    17296    riferimenti_biblio    TABLE     
  CREATE TABLE public.riferimenti_biblio (
    id_riferimento integer NOT NULL,
    titolo_riferimento character varying(200) NOT NULL,
    data_riferimento date,
    on_line boolean NOT NULL,
    tipo public.tipo_enum NOT NULL,
    url character varying(500),
    doi integer,
    descrizione character varying(1000),
    editore character varying(1000),
    isbn character varying(20),
    isnn character varying(20),
    luogo character varying(100),
    pag_inizio integer,
    pag_fine integer,
    edizione integer
);
 &   DROP TABLE public.riferimenti_biblio;
       public         heap    postgres    false    853            �            1259    17305    riferimenti_biblio_categorie    TABLE     �   CREATE TABLE public.riferimenti_biblio_categorie (
    riferimento_id_riferimento integer NOT NULL,
    categorie_id_categoria integer NOT NULL
);
 0   DROP TABLE public.riferimenti_biblio_categorie;
       public         heap    postgres    false            �            1259    17301 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE     �   ALTER TABLE public.riferimenti_biblio ALTER COLUMN id_riferimento ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.riferimenti_biblio_id_riferimento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    17302 &   riferimenti_biblio_riferimento_citante    TABLE     �   CREATE TABLE public.riferimenti_biblio_riferimento_citante (
    riferimento_citato_id_riferimento integer NOT NULL,
    riferimento_citante_id_riferimento integer NOT NULL
);
 :   DROP TABLE public.riferimenti_biblio_riferimento_citante;
       public         heap    postgres    false            �            1259    17285    riferimenti_biblio_user_id    TABLE     �   CREATE TABLE public.riferimenti_biblio_user_id (
    utente_user_id integer NOT NULL,
    riferimento_id_riferimento integer NOT NULL
);
 .   DROP TABLE public.riferimenti_biblio_user_id;
       public         heap    postgres    false            �            1259    17308    utente    TABLE     /  CREATE TABLE public.utente (
    user_id integer NOT NULL,
    username character varying(20) NOT NULL,
    nome character varying(200) NOT NULL,
    cognome character varying(200) NOT NULL,
    password_hashed character varying(500),
    salt character varying(500),
    email character varying(50)
);
    DROP TABLE public.utente;
       public         heap    postgres    false            �            1259    17313    utente_id_utente_seq    SEQUENCE     �   ALTER TABLE public.utente ALTER COLUMN user_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.utente_id_utente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            ;          0    17290 	   categoria 
   TABLE DATA           i   COPY public.categoria (id_categoria, descr_categoria, super_categoria_id_categoria, user_id) FROM stdin;
    public          postgres    false    215   �W       =          0    17296    riferimenti_biblio 
   TABLE DATA           �   COPY public.riferimenti_biblio (id_riferimento, titolo_riferimento, data_riferimento, on_line, tipo, url, doi, descrizione, editore, isbn, isnn, luogo, pag_inizio, pag_fine, edizione) FROM stdin;
    public          postgres    false    217   �Y       @          0    17305    riferimenti_biblio_categorie 
   TABLE DATA           j   COPY public.riferimenti_biblio_categorie (riferimento_id_riferimento, categorie_id_categoria) FROM stdin;
    public          postgres    false    220   i_       ?          0    17302 &   riferimenti_biblio_riferimento_citante 
   TABLE DATA           �   COPY public.riferimenti_biblio_riferimento_citante (riferimento_citato_id_riferimento, riferimento_citante_id_riferimento) FROM stdin;
    public          postgres    false    219   �_       :          0    17285    riferimenti_biblio_user_id 
   TABLE DATA           `   COPY public.riferimenti_biblio_user_id (utente_user_id, riferimento_id_riferimento) FROM stdin;
    public          postgres    false    214   P`       A          0    17308    utente 
   TABLE DATA           `   COPY public.utente (user_id, username, nome, cognome, password_hashed, salt, email) FROM stdin;
    public          postgres    false    221   �`       I           0    0    categoria_id_categoria_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);
          public          postgres    false    216            J           0    0 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.riferimenti_biblio_id_riferimento_seq', 69, true);
          public          postgres    false    218            K           0    0    utente_id_utente_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.utente_id_utente_seq', 48, true);
          public          postgres    false    222            �           2606    17315 f   riferimenti_biblio_riferimento_citante associazione_riferimenti_id_riferimento_id_riferimento_asso_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT associazione_riferimenti_id_riferimento_id_riferimento_asso_key UNIQUE (riferimento_citato_id_riferimento, riferimento_citante_id_riferimento);
 �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT associazione_riferimenti_id_riferimento_id_riferimento_asso_key;
       public            postgres    false    219    219            �           2606    17319 2   riferimenti_biblio_user_id autore_riferimento_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_user_id
    ADD CONSTRAINT autore_riferimento_pkey PRIMARY KEY (utente_user_id, riferimento_id_riferimento);
 \   ALTER TABLE ONLY public.riferimenti_biblio_user_id DROP CONSTRAINT autore_riferimento_pkey;
       public            postgres    false    214    214            �           2606    17321 7   categoria categoria_id_categoria_id_super_categoria_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_id_categoria_id_super_categoria_key UNIQUE (id_categoria, super_categoria_id_categoria);
 a   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_id_categoria_id_super_categoria_key;
       public            postgres    false    215    215            �           2606    17323    categoria categoria_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public            postgres    false    215            �           2606    17325 -   riferimenti_biblio riferimenti_biblio_doi_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_doi_key UNIQUE (doi);
 W   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_doi_key;
       public            postgres    false    217            �           2606    17327 .   riferimenti_biblio riferimenti_biblio_isbn_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_isbn_key UNIQUE (isbn);
 X   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_isbn_key;
       public            postgres    false    217            �           2606    17329 .   riferimenti_biblio riferimenti_biblio_isnn_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_isnn_key UNIQUE (isnn);
 X   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_isnn_key;
       public            postgres    false    217            �           2606    17331 *   riferimenti_biblio riferimenti_biblio_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_pkey PRIMARY KEY (id_riferimento);
 T   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_pkey;
       public            postgres    false    217            �           2606    17397    categoria titolounique 
   CONSTRAINT     \   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT titolounique UNIQUE (descr_categoria);
 @   ALTER TABLE ONLY public.categoria DROP CONSTRAINT titolounique;
       public            postgres    false    215            �           2606    17335    utente utente_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (user_id);
 <   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_pkey;
       public            postgres    false    221            �           2606    17337    utente utente_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_username_key;
       public            postgres    false    221            �           2620    17338 !   riferimenti_biblio articolo_check    TRIGGER     �   CREATE TRIGGER articolo_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.articolo_check();
 :   DROP TRIGGER articolo_check ON public.riferimenti_biblio;
       public          postgres    false    223    217    217            �           2620    17339 #   riferimenti_biblio conferenza_check    TRIGGER     �   CREATE TRIGGER conferenza_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.conferenza_check();
 <   DROP TRIGGER conferenza_check ON public.riferimenti_biblio;
       public          postgres    false    217    217    224            �           2620    17340 "   riferimenti_biblio fascicolo_check    TRIGGER     �   CREATE TRIGGER fascicolo_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.fascicolo_check();
 ;   DROP TRIGGER fascicolo_check ON public.riferimenti_biblio;
       public          postgres    false    217    227    217            �           2620    17341    riferimenti_biblio libro_check    TRIGGER     �   CREATE TRIGGER libro_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.libro_check();
 7   DROP TRIGGER libro_check ON public.riferimenti_biblio;
       public          postgres    false    225    217    217            �           2620    17342    riferimenti_biblio online_check    TRIGGER     �   CREATE TRIGGER online_check AFTER INSERT OR UPDATE OF on_line ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.online_check();
 8   DROP TRIGGER online_check ON public.riferimenti_biblio;
       public          postgres    false    217    217    226            �           2620    17343     riferimenti_biblio rivista_check    TRIGGER     �   CREATE TRIGGER rivista_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.rivista_check();
 9   DROP TRIGGER rivista_check ON public.riferimenti_biblio;
       public          postgres    false    217    217    228            �           2606    17344 ,   riferimenti_biblio_categorie fk_id_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_categorie
    ADD CONSTRAINT fk_id_categoria FOREIGN KEY (categorie_id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.riferimenti_biblio_categorie DROP CONSTRAINT fk_id_categoria;
       public          postgres    false    215    220    3213            �           2606    17349     categoria fk_id_categoria_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_categoria_utente FOREIGN KEY (user_id) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_categoria_utente;
       public          postgres    false    221    215    3227            �           2606    17354 .   riferimenti_biblio_categorie fk_id_riferimento    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_categorie
    ADD CONSTRAINT fk_id_riferimento FOREIGN KEY (riferimento_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.riferimenti_biblio_categorie DROP CONSTRAINT fk_id_riferimento;
       public          postgres    false    3223    220    217            �           2606    17359 3   riferimenti_biblio_user_id fk_id_riferimento_autore    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_user_id
    ADD CONSTRAINT fk_id_riferimento_autore FOREIGN KEY (riferimento_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.riferimenti_biblio_user_id DROP CONSTRAINT fk_id_riferimento_autore;
       public          postgres    false    3223    217    214            �           2606    17364 @   riferimenti_biblio_riferimento_citante fk_id_riferimento_citante    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT fk_id_riferimento_citante FOREIGN KEY (riferimento_citato_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT fk_id_riferimento_citante;
       public          postgres    false    219    217    3223            �           2606    17369 ?   riferimenti_biblio_riferimento_citante fk_id_riferimento_citato    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT fk_id_riferimento_citato FOREIGN KEY (riferimento_citante_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT fk_id_riferimento_citato;
       public          postgres    false    219    3223    217            �           2606    17374    categoria fk_id_super_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_super_categoria FOREIGN KEY (super_categoria_id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE SET NULL;
 I   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_super_categoria;
       public          postgres    false    215    3213    215            �           2606    17379 '   riferimenti_biblio_user_id fk_id_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_user_id
    ADD CONSTRAINT fk_id_utente FOREIGN KEY (utente_user_id) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.riferimenti_biblio_user_id DROP CONSTRAINT fk_id_utente;
       public          postgres    false    214    3227    221            ;   �  x�URAn�0</_�{�@$%�>��k$�7r(|Y[�L�"�
м��Ǻ�(�qv��K�xto>4��t �$��>�	�`�Qϼb9�t�:`��ǈ֠�f��I�.�����i��[�:D��~�[��f-��kkW[�jQ0���M��`B�w�xFRZ[H�WwX׆W���6~�D�����O����ฦ��?����s:��6��c@k���HO3U�6s�L��r&��F��ʠՉ]�����t^�~`+8��W�F(l⿿|�#$9#s�S+�?���Q��J�4%u0��|C;Z�\H�znI���6�Y0W��|m�4�B���oضSY�a�ʚ����*	�4qƪ�5=�᷷�Ā
�j�h�1��bM�����ֶ���^���Kⱸ�gߠ�Ҧ$���~�m9S_�d�X�9X�M7����~��)�<e��y���!�ƙ*`�M�$,��t��G�ǻwN��O�����m�      =   �  x��V�r�6>�O�Ng�C-� 	�LOJb��؊k99d2��(H�����鱇>E�&}�.HP?v�Q;#����v���-@Ѝ�jDc�b6�ST�5q���ϭ�ky\�<Ch�v�|İS�P%�r��O������+�h����3�Қ�t�|���d�/�tmb0J\�[��ժ��Q��Oַ}\�SF3�%F�A�i�Mwq��JU�x� <����jڡ�PY�NVj
=)Q['x6�ࠣ���ʪt��B��"9Um��&>�A����ye��l��SQ��Jt�
�f��.�m.x@�("C�����]�gN�~RZ�iS�ZY�+�dGy��,�>aД1�������d�n���/���]i�8Lq�e[�(zj�"�I�xD���h#G��ڀ�6�Y��1TD��C�Wx�@3D�D�8����Vխ2s|�l�Dy����0�F$x������ �aFbi�ڡ���l��פC��<e�1e	F$�H((dM�ڈYF�&R`�aS�sVl�0�i_/m�6$�:'1T��!�zK���/3"��� B��C���7F���T-*<�����Y��r��t�H�1�0.��Hz#^*-��UGp"9̉�lN�|��މ,�Y`$�F48��D ��<^���N�9�EX�`��ƈ�;�)8�hݞ�q�SC��7OUUZ��ϔ�X<��f��������~I�q��j3��PaJ���|�B�N*�#K���{�������=����`�(KѸTBk��r��nL���
�K�Q�^Y���������f�Ȫ#|a�{���)|A۩�mA����z���g��ͤ]�g)���S�/�s��-_	-����إ܈��h�2�W�V�: 1����9���V����7��#���u"�հm������5p4�P�+�l�ֵU:�!�Ԩ�#��Z
���c|s��k��X	�*<�5����__���Ϻ_��-}�腭j�-���P�����*wԍ��qK>?_[����Jc�Λ��k��p*�����qL�si�xH5Lѧs�I
�GYhȒ�S�"�3�=����n��C��.I޷B�I���O� 7-�[��k.��ן`C�u/����/���B|��X��I`Xc���|/�����+��-�x��ְ-�%1� 8��8�s�Po�9���g$��$�W��%{cGЦ#�0�R����q�TP.�?#���Fe1L������[_�^	/��x�-�[0�#� �x�Z	�y�yߵ���҉�
��<�{y��(�_��0�e�{��/�Q�9���T�(�HNqU6V?�q�Wʻ��o��k��]-�i�o��p��ԡ+���Q���K`J�����:`�``P8\���$'�~�v��GQ��~�      @   e   x�5ι�0�(�F�'��_Ǒ�8�2�+Zt$��a�+^0�A��)GP���)԰�3�musL!���97������{+�@>����x�H���      ?   b   x����0�jr�?S�({��?�Giph���ŀ�]昡���:�¦�i �a*g�¥��zV:S�E3�id3Y�5h�z�/���Nڟ����H��-:      :   p   x���0�R1���%���g�A,��`@Lv�P�B�_ȩ})�)�\��Rk�P�h�]W�5��������tCڔxR���آ,F��^˝�q�u�����߇�ց'      A     x�mU�r�6>�O�[O��ϲ|��&��f���f&�NH�d�)��l���}����͡��� ��
�F�a4���t�p� Oǻ=�v�՗Y��������Iv�Ha'�t�1XLZ^���ɇ"�^�>�$_ɚ�vxܛ�3I�%�
f-�G��L�w����YFY�p&s098�(&��g�I�
Z%�P��D��S�x?Zg��w��\�{�<q�:��t�a8I㦵u��`��J�*5G�g�ޖ��h�L|��V��-2(����`��QcU!�>��$�Z���^����i��]q���X�}{(���P��R�w�A��tw�P�����tH7�2/��T�0�G�m�Vv�-iO�хp��5����	!�U�iF�������mO�g�r(]L�|]R���i�p���:���V�8�it޷e�rY��J�!Ǯcp�h��߿6���H�;�ړ��J�s5{�ͼ�~�oʸ��yc�3O�i����q�Jʞ��w�j�6*�u5�EyD�h���(�R�]�Qt�MQb��|b��E��	O�V��ֺ\�[�������G����y��P�P����6d�����s]�_�Z�Z��]#�Cj����c�� u[٢���KK���uz��7��{��jʐVM���d�s�%��0N�$�*�����O=�V��������Zy7s2GYj�\��^�h7ء1�\Ea�Fi�.���{�BU�jux^�0�}��So�/mz���fd7��q�i ���+��ϝ~g�0I3�����lJ�<Z$�<����_�v��á����~T..�,^Pγ8��J�]I�r%� ��U�Pڳ��*�"��e�}��|?�(�-[��$��V�'δ��_4]�W�X�{�7wD��O�(L�0M�h�&���}���X��ˮ��)���{�^跳8�Rc��	�B��@�L9�	��,H�`Iͽ��Y�ܡ�V��x����qzTw
s�ᖳZaI����(�~�]�zN%9q�\�1���g�F����S^\�>�B��8��Ju�S�=�v�v=���2I�(#vM�^�4���k}��on���*G7��
��2�P� ���T���m��)�L.�����Y�p���@��;̉��H?%�ξq��p�FI�$�İ~}i����KF^|I�2����c�r�#o�	��p�=�%W�l��N6�p'�-4��4��g�5��nI�p�	[k��ӽ�wɌT�v��Q��<��$�RXS�ؽ��̻��W���_ߨ��     