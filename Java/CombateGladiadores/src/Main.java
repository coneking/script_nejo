
import java.util.InputMismatchException;
import java.util.Scanner;

public class Main {

    public static Scanner s = new Scanner(System.in);

    public static void main(String[] args) {
        String nombre = "";
        int fuerza = 0;
        int danoataque = 0;
        int opcion = 0;
        int op = 0;
        int op2 = 0;
        String luchador1 = "";
        String luchador2 = "";
        String hist_hm = "Soy entero vioh y voh entero loggi, te tiraste!!!";
        String hist_ef = "Chispea antes que te raje el paño, ya saí ya!!!";
        String hist_en = "Y a voh quien te movio la jaula pajarraco???";

        do {
            System.out.println("** Luchador Raza: Elfo **");
            System.out.print("Ingrese el nombre del luchador: ");
            nombre = s.nextLine();
            if (nombre.isEmpty()) {
                System.out.println("Nombre no Valido");
            }
        } while (nombre.isEmpty());

        do {
            try {
                System.out.print("Ingrese la fuerza de " + nombre + " (1-5): ");
                fuerza = Integer.parseInt(s.nextLine());
                System.out.println("\n");
            } catch (Exception e) {
                System.out.println("ingrese un numero entre 1 y 5");
            }

        } while (fuerza < 1 || fuerza > 5);
        Gladiador g1 = new Gladiador();
        g1.setNombre(nombre);
        g1.setFuerza(fuerza);

        do {
            System.out.println("** Luchador Raza: Enano **");
            System.out.print("Ingrese el nombre del luchador: ");
            nombre = s.nextLine();
            if (nombre.isEmpty()) {
                System.out.println("Nombre no Valido");
            }
        } while (nombre.isEmpty());

        do {
            try {
                System.out.print("Ingrese la fuerza de " + nombre + " (1-5): ");
                fuerza = Integer.parseInt(s.nextLine());
                System.out.println("\n");
            } catch (Exception e) {
                System.out.println("ingrese un numero entre 1 y 5");
            }

        } while (fuerza < 1 || fuerza > 5);
        Gladiador g2 = new Gladiador();
        g2.setNombre(nombre);
        g2.setFuerza(fuerza);

        do {
            System.out.println("** Luchador Raza: Hombre **");
            System.out.print("Ingrese el nombre del luchador: ");
            nombre = s.nextLine();
            if (nombre.isEmpty()) {
                System.out.println("Nombre no Valido");
            }
        } while (nombre.isEmpty());

        do {
            try {
                System.out.print("Ingrese la fuerza de " + nombre + " (1-5): ");
                fuerza = Integer.parseInt(s.nextLine());
                System.out.println("\n");
            } catch (Exception e) {
                System.out.println("ingrese un numero entre 1 y 5");
            }
        } while (fuerza < 1 || fuerza > 5);
        Gladiador g3 = new Gladiador();
        g3.setNombre(nombre);
        g3.setFuerza(fuerza);

        System.out.println("** Menú de Combate **");

        while (op <= 0 || op > 3) {
            System.out.println("Seleccione el primer luchador: \n");
            System.out.println("1) " + g1.getNombre() + "\n2) " + g2.getNombre() + "\n3) " + g3.getNombre() + "\n");
            System.out.print("Opción: ");
            try {
                op = Integer.parseInt(s.nextLine());
            } catch (InputMismatchException ex) {
                s.nextLine();
                //System.out.print("Valor ingresado incorrecto, inténtelo una vez más\n");
            } catch (NumberFormatException ex) {
                System.out.println("No ingresó un número \n");
            }

        }
        g1.setHistoria(hist_ef);
        g2.setHistoria(hist_en);
        g3.setHistoria(hist_hm);
        if (op == 1) {
            System.out.println("Seleccionó al luchador: " + g1.getNombre());
            luchador1 = g1.getNombre();
            while (op2 <= 0 || op2 > 2) {
                System.out.println("Seleccione el siguiente luchador: \n");
                System.out.println("1) " + g2.getNombre() + "\n2) " + g3.getNombre() + "\n");
                System.out.print("Opción: ");
                try {
                    op2 = Integer.parseInt(s.nextLine());
                } catch (InputMismatchException ex) {
                    s.nextLine();
                    //System.out.print("Valor ingresado incorrecto, inténtelo una vez más\n");
                } catch (NumberFormatException ex) {
                    System.out.println("No ingresó un número \n");
                }
                System.out.println("\n");
            }
            if (op2 == 1) {
                System.out.println("LUCHADORES!!!\n");
                System.out.println(g1.getNombre() + "\n\t" + g1.getHistoria() + "\n");
                System.out.println("\t##########");
                System.out.println("\t##  VS  ##");
                System.out.println("\t##########");
                System.out.println(g2.getNombre() + "\n\t" + g2.getHistoria() + "\n");
                luchador2 = g2.getNombre();

            } else {
                System.out.println("LUCHADORES!!!\n");
                System.out.println(g1.getNombre() + "\n\t" + g1.getHistoria() + "\n");
                System.out.println("\t##########");
                System.out.println("\t##  VS  ##");
                System.out.println("\t##########");
                System.out.println(g3.getNombre() + "\n\t" + g3.getHistoria() + "\n");
                luchador2 = g3.getNombre();
            }

        } else if (op == 2) {
            System.out.println("Seleccionó al luchador: " + g2.getNombre());
            luchador1 = g2.getNombre();
            while (op2 <= 0 || op2 > 2) {
                System.out.println("Seleccione el siguiente luchador: \n");
                System.out.println("1) " + g1.getNombre() + "\n2) " + g3.getNombre() + "\n");
                System.out.print("Opción: ");
                try {
                    op2 = Integer.parseInt(s.nextLine());
                } catch (InputMismatchException ex) {
                    s.nextLine();
                    //System.out.print("Valor ingresado incorrecto, inténtelo una vez más\n");
                } catch (NumberFormatException ex) {
                    System.out.println("No ingresó un número \n");
                }
            }
            if (op2 == 1) {
                System.out.println("LUCHADORES!!!\n");
                System.out.println(g2.getNombre() + "\n\t" + g2.getHistoria() + "\n");
                System.out.println("\t##########");
                System.out.println("\t##  VS  ##");
                System.out.println("\t##########");
                System.out.println(g1.getNombre() + "\n\t" + g1.getHistoria() + "\n");
                luchador2 = g1.getNombre();
            } else {
                System.out.println("LUCHADORES!!!\n");
                System.out.println(g2.getNombre() + "\n\t" + g2.getHistoria() + "\n");
                System.out.println("\t##########");
                System.out.println("\t##  VS  ##");
                System.out.println("\t##########");
                System.out.println(g3.getNombre() + "\n\t" + g3.getHistoria() + "\n");
                luchador2 = g3.getNombre();
            }
        } else {
            System.out.println("Seleccionó al luchador: " + g3.getNombre());
            luchador1 = g3.getNombre();
            while (op2 <= 0 || op2 > 2) {
                System.out.println("Elija el siguiente luchador: \n");
                System.out.println("1) " + g1.getNombre() + "\n2) " + g2.getNombre() + "\n");
                System.out.print("Opción: ");
                try {
                    op2 = Integer.parseInt(s.nextLine());
                } catch (InputMismatchException ex) {
                    s.nextLine();
                    //System.out.print("Valor ingresado incorrecto, inténtelo una vez más\n");
                }
            }
            if (op2 == 1) {
                System.out.println("LUCHADORES!!!\n");
                System.out.println(g3.getNombre() + "\n\t" + g3.getHistoria() + "\n");
                System.out.println("\t##########");
                System.out.println("\t##  VS  ##");
                System.out.println("\t##########");
                System.out.println(g1.getNombre() + "\n\t" + g1.getHistoria() + "\n");
                luchador2 = g1.getNombre();

            } else {
                System.out.println("LUCHADORES!!!\n");
                System.out.println(g3.getNombre() + "\n\t" + g3.getHistoria() + "\n");
                System.out.println("\t##########");
                System.out.println("\t##  VS  ##");
                System.out.println("\t##########");
                System.out.println(g2.getNombre() + "\n\t" + g2.getHistoria() + "\n");
                luchador2 = g2.getNombre();
            }
        }
        System.out.println("\n");

        if (op == 1 && op2 == 1 || op == 2 && op2 == 1) {
            do {
                System.out.print("Ingrese el número del luchador que atacará. \n\n1) " + luchador1 + "\n2) " + luchador2 + "\nAtaca: ");
                opcion = Integer.parseInt(s.nextLine());
                switch (opcion) {
                    case 1:
                        danoataque = g1.atacar();
                        System.out.println(g1.getNombre() + " atacó a " + g2.getNombre() + " y el daño fue de " + danoataque + " puntos!!!");
                        g2.recibirDano(danoataque);
                        System.out.println("\n");
                        if (g2.getEstado().equals("Derrotado")) {
                            System.out.println(g2.getNombre() + " ha sido derroatado!");
                        }
                        break;
                    case 2:
                        danoataque = g2.atacar();
                        System.out.println(g2.getNombre() + " atacó a " + g1.getNombre() + " y el daño fue de " + danoataque + "!");
                        g1.recibirDano(danoataque);
                        System.out.println("\n");
                        if (g1.getEstado().equals("Derrotado")) {
                            System.out.println(g1.getNombre() + " ha sido derroatado!");
                        }
                        break;
                    default:
                        System.out.println("Ingrese opción 1 o 2 \n");
                        System.out.println();
                                   
                }
                System.out.println("La energía de " + g1.getNombre() + " es " + g1.getEnergia());
                System.out.println("La energía de " + g2.getNombre() + " es " + g2.getEnergia());
                System.out.println("\n");
            } while (g1.getEstado().equals("En guardia") && g2.getEstado().equals("En guardia"));
        } else if (op == 1 && op2 == 2 || op == 3 && op2 == 1) {
            do {
                System.out.print("Ingrese el número del luchador que atacará. \n\n1) " + luchador1 + "\n2) " + luchador2 + "\nAtaca: ");
                opcion = Integer.parseInt(s.nextLine());
                switch (opcion) {
                    case 1:
                        danoataque = g1.atacar();
                        System.out.println(g1.getNombre() + " atacó a " + g3.getNombre() + " y el daño fue de " + danoataque + " puntos!!!");
                        g3.recibirDano(danoataque);
                        System.out.println("\n");
                        if (g3.getEstado().equals("Derrotado")) {
                            System.out.println(g3.getNombre() + " ha sido derroatado!");
                        }
                        break;
                    case 2:
                        danoataque = g3.atacar();
                        System.out.println(g3.getNombre() + " atacó a " + g1.getNombre() + " y el daño fue de " + danoataque + "!");
                        g1.recibirDano(danoataque);
                        System.out.println("\n");
                        if (g1.getEstado().equals("Derrotado")) {
                            System.out.println(g1.getNombre() + " ha sido derrotado!");
                        }
                        break;
                }
                System.out.println("La energía de " + g1.getNombre() + " es " + g1.getEnergia());
                System.out.println("La energía de " + g3.getNombre() + " es " + g3.getEnergia());
                System.out.println("\n");
            } while (g1.getEstado().equals("En guardia") && g3.getEstado().equals("En guardia"));
        } else {
            do {
                System.out.print("Ingrese el número del luchador que atacará. \n\n1) " + luchador1 + "\n2) " + luchador2 + "\nAtaca: ");
                opcion = Integer.parseInt(s.nextLine());
                switch (opcion) {
                    case 1:
                        danoataque = g2.atacar();
                        System.out.println(g2.getNombre() + " atacó a " + g3.getNombre() + " y el daño fue de " + danoataque + " puntos!!!");
                        g3.recibirDano(danoataque);
                        System.out.println("\n");
                        if (g3.getEstado().equals("Derrotado")) {
                            System.out.println(g3.getNombre() + " ha sido derrotado!");
                        }
                        break;
                    case 2:
                        danoataque = g3.atacar();
                        System.out.println(g3.getNombre() + " atacó a " + g2.getNombre() + " y el daño fue de " + danoataque + "!");
                        g2.recibirDano(danoataque);
                        System.out.println("\n");
                        if (g2.getEstado().equals("Derrotado")) {
                            System.out.println(g2.getNombre() + " ha sido derrotado!");
                        }
                        break;
                }
                System.out.println("La energía de " + g2.getNombre() + " es " + g2.getEnergia());
                System.out.println("La energía de " + g3.getNombre() + " es " + g3.getEnergia());
                System.out.println("\n");
            } while (g2.getEstado().equals("En guardia") && g3.getEstado().equals("En guardia"));
        }

        System.out.println("Fin del combate");
    }

}
