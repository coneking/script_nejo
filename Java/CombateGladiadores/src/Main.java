
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

        System.out.println("** Luchador Raza: Elfo **");
        System.out.print("Ingrese el nombre del luchador: ");
        nombre = s.nextLine();
        do {
            System.out.print("Ingrese la fuerza de " + nombre + " (1-5): ");
            fuerza = Integer.parseInt(s.nextLine());
            System.out.println("\n");
        } while (fuerza < 1 || fuerza > 5);
        Gladiador g1 = new Gladiador();
        g1.setNombre(nombre);
        g1.setFuerza(fuerza);

        System.out.println("** Luchador Raza: Enano **");
        System.out.print("Ingrese el nombre del luchador: ");
        nombre = s.nextLine();
        do {
            System.out.print("Ingrese la fuerza de " + nombre + " (1-5): ");
            fuerza = Integer.parseInt(s.nextLine());
            System.out.println("\n");
        } while (fuerza < 1 || fuerza > 5);
        Gladiador g2 = new Gladiador();
        g2.setNombre(nombre);
        g2.setFuerza(fuerza);

        System.out.println("** Luchador Raza: Hombre **");
        System.out.print("Ingrese el nombre del luchador: ");
        nombre = s.nextLine();
        do {
            System.out.print("Ingrese la fuerza de " + nombre + " (1-5): ");
            fuerza = Integer.parseInt(s.nextLine());
            System.out.println("\n");
        } while (fuerza < 1 || fuerza > 5);
        Gladiador g3 = new Gladiador();
        g3.setNombre(nombre);
        g3.setFuerza(fuerza);

        System.out.println("** Menú de Combate **");

        while (op <= 0 || op > 3) {
            System.out.println("Elija los luchadores: \n");
            System.out.println("1) " + g1.getNombre() + "\n2) " + g2.getNombre() + "\n3) " + g3.getNombre() + "\n");
            System.out.print("Opción: ");
            try {
                op = Integer.parseInt(s.nextLine());
            } catch (InputMismatchException ex) {
                s.nextLine();
                //System.out.print("Valor ingresado incorrecto, inténtelo una vez más\n");
            }
        }
        if (op == 1) {
            System.out.println("Seleccionó al luchador: " + g1.getNombre());
            luchador1 = g1.getNombre();
            while (op2 <= 0 || op2 > 2) {
                System.out.println("Elija el siguiente luchador: \n");
                System.out.println("1) " + g2.getNombre() + "\n2) " + g3.getNombre() + "\n");
                System.out.print("Opción: ");
                try {
                    op2 = Integer.parseInt(s.nextLine());
                } catch (InputMismatchException ex) {
                    s.nextLine();
                    //System.out.print("Valor ingresado incorrecto, inténtelo una vez más\n");
                }
                System.out.println("\n");
            }
            if(op2 == 1){
                System.out.println("LUCHADORES!!!");
                System.out.println(g1.getNombre() +" VS "+g2.getNombre() );
                luchador2 = g1.getNombre();
            }else{
                System.out.println("LUCHADORES!!!");
                System.out.println(g1.getNombre() +" VS "+g3.getNombre());
                luchador2 = g2.getNombre();
            }
            
        } else if (op == 2) {
            System.out.println("Seleccionó al luchador: " + g2.getNombre());
            luchador1 = g2.getNombre();
            while (op2 <= 0 || op2 > 2) {
                System.out.println("Elija el siguiente luchador: \n");
                System.out.println("1) " + g1.getNombre() + "\n2) " + g3.getNombre() + "\n");
                System.out.print("Opción: ");
                try {
                    op2 = Integer.parseInt(s.nextLine());
                } catch (InputMismatchException ex) {
                    s.nextLine();
                    //System.out.print("Valor ingresado incorrecto, inténtelo una vez más\n");
                }
            }
            if(op2 == 1){
                System.out.println("LUCHADORES!!!");
                System.out.println(g1.getNombre() +" VS "+g2.getNombre() );
                luchador2 = g2.getNombre();
            }else{
                System.out.println("LUCHADORES!!!");
                System.out.println(g1.getNombre() +" VS "+g3.getNombre());
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
            if(op2 == 1){
                System.out.println("LUCHADORES!!!");
                System.out.println(g1.getNombre() +" VS "+g2.getNombre());
                luchador2 = g1.getNombre();
            }else{
                System.out.println("LUCHADORES!!!");
                System.out.println(g1.getNombre() +" VS "+g3.getNombre());
                luchador2 = g3.getNombre();
            }
        }
        System.out.println("\n");

        do {
            System.out.println("Ingrese el número del luchador que atacará (1. " + luchador1 + " - 2. " + luchador2 + ")");
            opcion = Integer.parseInt(s.nextLine());
            switch (opcion) {
                case 1:
                    danoataque = g1.atacar();
                    System.out.println(g1.getNombre() + " atacó a " + g2.getNombre() + " y el daño fue de " + danoataque + "!");
                    g2.recibirDano(danoataque);
                    if (g2.getEstado().equals("Derrotado")) {
                        System.out.println(g2.getNombre() + " ha sido derroatado!");
                    }
                    break;
                case 2:
                    danoataque = g2.atacar();
                    System.out.println(g2.getNombre() + " atacó a " + g1.getNombre() + " y el daño fue de " + danoataque + "!");
                    g1.recibirDano(danoataque);
                    if (g1.getEstado().equals("Derrotado")) {
                        System.out.println(g1.getNombre() + " ha sido derroatado!");
                    }
                    break;
            }
            System.out.println("La energía de " + g1.getNombre() + " es " + g1.getEnergia());
            System.out.println("La energía de " + g2.getNombre() + " es " + g2.getEnergia());
        } while (g1.getEstado().equals("En guardia") && g2.getEstado().equals("En guardia"));
        System.out.println("Fin del combate");
    }

}
