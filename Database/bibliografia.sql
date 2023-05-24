PGDMP     +    :                {           bibliografia    15.1    15.1 :    E           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
       public          postgres    false            �            1255    17283    sub_cat(integer)    FUNCTION     �  CREATE FUNCTION public.sub_cat(catin integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
codiciString VARCHAR(100) := '';
catTmp integer := catIn;
i record;
BEGIN
FOR i IN (SELECT ID_Categoria FROM Categoria WHERE ID_Super_Categoria = catTmp)
LOOP
	codiciString := codiciString||i.ID_Categoria||',';
	codiciString := codiciString||sub_cat(i.ID_Categoria);
END LOOP;
codiciString := RTRIM(codiciString,',');
RETURN codiciString;
END;
$$;
 -   DROP FUNCTION public.sub_cat(catin integer);
       public          postgres    false            �            1255    17284    super_cat(integer)    FUNCTION     +  CREATE FUNCTION public.super_cat(catin integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
codiciString VARCHAR(100) := '';
catTmp integer := catIn;
supercatTmp integer := (SELECT ID_Super_Categoria FROM Categoria WHERE ID_Categoria = catTmp);
BEGIN
WHILE supercatTmp IS NOT NULL
BEGIN LOOP
	codiciString := codiciString||supercatTmp||',';
	catTmp := supercatTmp;
	supercatTmp := (SELECT ID_Super_Categoria FROM Categoria WHERE ID_Categoria = catTmp);
END LOOP;
codiciString := RTRIM(codiciString,',');
RETURN codiciString;
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
    public          postgres    false    220   ]       ?          0    17302 &   riferimenti_biblio_riferimento_citante 
   TABLE DATA           �   COPY public.riferimenti_biblio_riferimento_citante (riferimento_citato_id_riferimento, riferimento_citante_id_riferimento) FROM stdin;
    public          postgres    false    219   z]       :          0    17285    riferimenti_biblio_user_id 
   TABLE DATA           `   COPY public.riferimenti_biblio_user_id (utente_user_id, riferimento_id_riferimento) FROM stdin;
    public          postgres    false    214   �]       A          0    17308    utente 
   TABLE DATA           `   COPY public.utente (user_id, username, nome, cognome, password_hashed, salt, email) FROM stdin;
    public          postgres    false    221   N^       I           0    0    categoria_id_categoria_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);
          public          postgres    false    216            J           0    0 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.riferimenti_biblio_id_riferimento_seq', 52, true);
          public          postgres    false    218            K           0    0    utente_id_utente_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.utente_id_utente_seq', 33, true);
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
       public            postgres    false    217            �           2606    17333 -   riferimenti_biblio riferimenti_biblio_url_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_url_key UNIQUE (url);
 W   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_url_key;
       public            postgres    false    217            �           2606    17335    utente utente_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (user_id);
 <   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_pkey;
       public            postgres    false    221            �           2606    17337    utente utente_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_username_key;
       public            postgres    false    221            �           2620    17338 !   riferimenti_biblio articolo_check    TRIGGER     �   CREATE TRIGGER articolo_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.articolo_check();
 :   DROP TRIGGER articolo_check ON public.riferimenti_biblio;
       public          postgres    false    217    217    223            �           2620    17339 #   riferimenti_biblio conferenza_check    TRIGGER     �   CREATE TRIGGER conferenza_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.conferenza_check();
 <   DROP TRIGGER conferenza_check ON public.riferimenti_biblio;
       public          postgres    false    217    217    224            �           2620    17340 "   riferimenti_biblio fascicolo_check    TRIGGER     �   CREATE TRIGGER fascicolo_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.fascicolo_check();
 ;   DROP TRIGGER fascicolo_check ON public.riferimenti_biblio;
       public          postgres    false    229    217    217            �           2620    17341    riferimenti_biblio libro_check    TRIGGER     �   CREATE TRIGGER libro_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.libro_check();
 7   DROP TRIGGER libro_check ON public.riferimenti_biblio;
       public          postgres    false    225    217    217            �           2620    17342    riferimenti_biblio online_check    TRIGGER     �   CREATE TRIGGER online_check AFTER INSERT OR UPDATE OF on_line ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.online_check();
 8   DROP TRIGGER online_check ON public.riferimenti_biblio;
       public          postgres    false    226    217    217            �           2620    17343     riferimenti_biblio rivista_check    TRIGGER     �   CREATE TRIGGER rivista_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.rivista_check();
 9   DROP TRIGGER rivista_check ON public.riferimenti_biblio;
       public          postgres    false    230    217    217            �           2606    17344 ,   riferimenti_biblio_categorie fk_id_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_categorie
    ADD CONSTRAINT fk_id_categoria FOREIGN KEY (categorie_id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.riferimenti_biblio_categorie DROP CONSTRAINT fk_id_categoria;
       public          postgres    false    220    215    3213            �           2606    17349     categoria fk_id_categoria_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_categoria_utente FOREIGN KEY (user_id) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_categoria_utente;
       public          postgres    false    215    221    3227            �           2606    17354 .   riferimenti_biblio_categorie fk_id_riferimento    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_categorie
    ADD CONSTRAINT fk_id_riferimento FOREIGN KEY (riferimento_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.riferimenti_biblio_categorie DROP CONSTRAINT fk_id_riferimento;
       public          postgres    false    220    217    3221            �           2606    17359 3   riferimenti_biblio_user_id fk_id_riferimento_autore    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_user_id
    ADD CONSTRAINT fk_id_riferimento_autore FOREIGN KEY (riferimento_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.riferimenti_biblio_user_id DROP CONSTRAINT fk_id_riferimento_autore;
       public          postgres    false    214    3221    217            �           2606    17364 @   riferimenti_biblio_riferimento_citante fk_id_riferimento_citante    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT fk_id_riferimento_citante FOREIGN KEY (riferimento_citato_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT fk_id_riferimento_citante;
       public          postgres    false    217    3221    219            �           2606    17369 ?   riferimenti_biblio_riferimento_citante fk_id_riferimento_citato    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT fk_id_riferimento_citato FOREIGN KEY (riferimento_citante_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT fk_id_riferimento_citato;
       public          postgres    false    217    3221    219            �           2606    17374    categoria fk_id_super_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_super_categoria FOREIGN KEY (super_categoria_id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE SET NULL;
 I   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_super_categoria;
       public          postgres    false    215    3213    215            �           2606    17379 '   riferimenti_biblio_user_id fk_id_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_user_id
    ADD CONSTRAINT fk_id_utente FOREIGN KEY (utente_user_id) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.riferimenti_biblio_user_id DROP CONSTRAINT fk_id_utente;
       public          postgres    false    221    3227    214            ;   �  x�UR�n�0}��B����%y��,h�F7�a��Y
d���5�����[������"<�wZ�tFx{�D$�=�@#RB�3F��Z�p41���(#ZB7�݈�,u~|��.�.�7��2D3�-|#�;�>�*���Ү���*j��n.��P
�b��B�m���\�cӐ�IV�7�?ɻY���D��ȗ�H6P�\U���-�K��[?yŀ����@e+US�z���d��H��	������s��'����/�M0Ѱ���ҍ�Hx3I
�\ʛ?�l���6�͚*��^�ٰcstf���	��Or�z�L�p[^{�P�9�z����P���c| �5��nI+x�h�k=���u?�͊��&��/o�ep0�5��(���Rm���9��1�0�~j���Sr��E�9^�N�۽��a�)      =   e  x��VMo�8=S��{�)�"�� H� ��H�=�0���IC� �h����F�-m�@ے8o�̼G
����)�'L�0Iz��ߵ�<==���x�ԧU���B�R�Y����W�[[w��J �VǏ(x��S�9�aS�uxvi��&���!�&n��N�ٞ���b�0'�jqx��(-/�F�B�2��9��]��+�Z�OS�U��!j�Q�9����E&�j�����)_������D[��S��ܺ��/�i��z_���@@�R̆g
�����ǥR����������YZ=��a���g3�]6>M�*���l�c�!����ϐP��0j��F�<�R[ d�%��*�#V�߷5���k|���=�����i$�N��O�]��ЩO`�Y�]l��Ր�ˬ�=@��c�a�`�ʪ֤, ��;!8*���Yʒ�wQ�ʰjaN�QvBXe`��ȗ���6��6�ʁ!��-fH�Y@�!,�!�>ԣ@4��c�v�w���k���H����u����严M���}�B��#;�9�5\�I�G'*�T�@�<;�/r"6Vi�������2� n~W�����kO�o���;��5��:d¥���C��uӷ>���2�$�ܢ�k��(&(P4o��`��Hr�Ӏ�E���J�>&�%IԐ�+��1��o������cy�P����i3D��� �;�u�'f�w[�é�_�G�>��%J���ᛃ��΅
]@�o�jļ��í1 �5Ơꐯ�Z�_�9� ��x=��G�#8��s����uW�H%��z[�;�F+���!�E������^.����������{�E�%����]�:-��?����      @   N   x�%���0�7S���.�����>����7�p�M-QFP���'���{8z�rN��#ƞ��"�l�F      ?   V   x���!���b~�1z�����%%b8���ٶE����Mç�fj�쒥k��TW��pU��tne9K�>_�Q�띿x~��ة�      :   ^   x�%���0C�3Y��_��K��c��B�ҡ�.<���%��h>"MǠe����\�M)�����\��ʉrV���w�Z]�Ј;�������ɺG      A   �  x�ETkr�8��>�/0)���_�8�n�xvj<��d�G	K7�s�Ŷ%��r��-����
`��� Nx0�2�*����´���mB�%���`��+����C2�i4;Hg=��I�X��b(r�5��Z�LDp��bZ�AI.�%�Z{�wL��&�2ÒҬ��t�\f`bl�Q��˚	�#]+(��Dm8��Q�J��g?Umri���M�<~�%��u��汳_�UKa�j����-�Uѩ����fy�=��`�UU)r�R�^c�!�S҇	�R�M�W�8�:Dx s)�T��}�m��>~0��6���j=<��*Q�����pI��.���8�%`Ϫ#���+��4J�G�sjL`�+�d�f���f�3�?�ښԯd�PZ'L�|P]St��YOa���N��ͅ�(c�>u.�)-X,�k]�b�*$@���-��#ê?�W��J	�f�Dͼ���ʸ��Ya>;�����qk-eM�yֻ{�cto�L7({��B｀�(e19���l�(���+>L/GD<�'��K(X�z�s,�:��=s|*qv4���8��HN�ĭ�<�u�2���D�R��)R�Ϩt_{8�#Ҷ�%J��n�����<�����#WMNҩ�_��y�:��%�΃hNhȯ]�_�_�;����ż=|���L5Sn�N�#�=Vh��Pa0����|ŅW՛*+�����qcN8��֦��7�0#�Y���A0��}N���$��+�
ZN�a[��|Ly$�(���Y�� y�^��.���o����q�$=O9ܻ�r��b_�E�&K*��o���¦M���qy+��Io��4��X��4Ǳ�'��2G�'�v|TY�"\,��j������`'۬E������@�J$��V�[�hH1���-�#������?�aM�y�h͇��������1���swC�7)�!n�R�F���h��n�     