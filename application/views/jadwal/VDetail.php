<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Ini adalah detail rapat kamu</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <div class="p-lg-4">
                            <p>
                                <strong><?php echo $jadwal[0]->judul_rapat ?></strong>
                            </p>
                            <p class="pt-2">
                                <strong>Komunitas : </strong> <?php echo $jadwal[0]->nama_komunitas ?>
                            </p>
                            <p class="pt-2">
                                <strong>Detail Rapat :</strong><br>
                                <?php echo $jadwal[0]->isi ?>
                            </p>
                            <p class="pt-2">
                                <strong>Hari, Tanggal : </strong> <?php echo date("l, d M Y", strtotime($jadwal[0]->tanggal)) ?>
                            </p>
                            <p class="pt-2">
                                <strong>Waktu, Tanggal : </strong> <?php echo date("H:s:i", strtotime($jadwal[0]->waktu)) ?>
                            </p>
                            <div class="pt-4">
                                <a href="<?php echo base_url() ?>jadwal/delete/<?php echo $jadwal[0]->id_komunitas ?>/<?php echo $jadwal[0]->id ?>" class="btn btn-sm btn-danger">
                                    Hapus Jadwal
                                </a>
                                <a href="<?php echo base_url() ?>jadwal/update/<?php echo $jadwal[0]->id_komunitas ?>/<?php echo $jadwal[0]->id ?>" class="btn btn-sm btn-secondary">
                                    Update Jadwal
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>