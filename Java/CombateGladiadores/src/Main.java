
import java.util.Scanner;


public class Main {
    
    public static Scanner s = new Scanner(System.in);
    public static void main(String[] args) {
        String nombre = "";
        int fuerza = 0;
        int danoataque = 0;
        int opcion = 0;
        System.out.println("** Primer Gladiador **");
        System.out.println("Ingrese el nombre del gladiador");
        nombre = s.nextLine();
        do{
            System.out.println("Ingrese la fuerza de "+nombre + "(1-5)");
            fuerza = Integer.parseInt(s.nextLine());
        }while(fuerza < 1 || fuerza > 5);
        Gladiador g1 = new Gladiador();
        g1.setNombre(nombre);
        g1.setFuerza(fuerza);
        
                System.out.println("** Segundo Gladiador **");
        System.out.println("Ingrese el nombre del gladiador");
        nombre = s.nextLine();
        do{
            System.out.println("Ingrese la fuerza de "+nombre + "(1-5)");
            fuerza = Integer.parseInt(s.nextLine());
        }while(fuerza < 1 || fuerza > 5);
        Gladiador g2 = new Gladiador();
        g2.setNombre(nombre);
        g2.setFuerza(fuerza);
        
        System.out.println("** Menú de Combate **");
        do{
            System.out.println("Ingrese el número del gladiador que atacará (1. "+ g1.getNombre() +" - 2. "+ g2.getNombre()+ ")");
            opcion = Integer.parseInt(s.nextLine());
            switch(opcion){
                case 1: 
                    danoataque = g1.atacar();
                    System.out.println(g1.getNombre() + " atacó a "+ g2.getNombre() + " y el daño fue de " + danoataque + "!");
                    g2.recibirDano(danoataque);
                    if(g2.getEstado().equals("Derrotado")){
                        System.out.println(g2.getNombre() +" ha sido derroatado!");
                    }
                    break;
                case 2:
                    danoataque = g2.atacar();
                    System.out.println(g2.getNombre() + " atacó a "+ g1.getNombre() + " y el daño fue de " + danoataque + "!");
                    g1.recibirDano(danoataque);
                    if(g1.getEstado().equals("Derrotado")){
                        System.out.println(g1.getNombre() +" ha sido derroatado!");
                    }
                    break;
            }
            System.out.println("La energía de "+  g1.getNombre() +" es "+ g1.getEnergia());
            System.out.println("La energía de "+  g2.getNombre() +" es "+ g2.getEnergia());
        }while(g1.getEstado().equals("En guardia") && g2.getEstado().equals("En guardia"));
        System.out.println("Fin del combate");
    }
    
}
