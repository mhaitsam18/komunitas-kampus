<div class="main-content" id="panel">
    <?php $this->load->view('layouts/Navbar'); ?>
    <div class="header bg-danger pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-12">
                        <h2 class="text-white mb-0 mt-4">Hi Kak <?php echo $this->session->userdata('name'); ?> </h2>
                        <p class="text-white mb-2">Selamat datang di laman absensi komunitas</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header border-0">
                        <h4 class="mb-0">Agenda Kamu</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table align-items-center table-flush">
                            <thead class="thead-light">
                                <tr>
                                    <th class="text-center">Nama Anggota</th>
                                    <th class="text-center">Kehadiran</th>
                                    <th class="text-center"></th>
                                </tr>
                            </thead>
                            <tbody class="list">
                                <?php if ($absensi) { ?>
                                    <?php foreach ($absensi as $a) { ?>
                                        <tr>
                                            <td class="text-center"><?= $a->nama_user ?></td>
                                            <?php if ($a->kehadiran) { ?>
                                                <?php if ($a->kehadiran == '1') { ?>
                                                    <td class="text-center">
                                                        <div class="badge badge-success">Hadir</div>
                                                    </td>
                                                <?php } elseif ($a->kehadiran == '2') { ?>
                                                    <td class="text-center">
                                                        <div class="badge badge-danger">Tidak Hadir</div>
                                                    </td>
                                                <?php } ?>
                                            <?php } else { ?>
                                                <td class="text-center">
                                                    <a href="<?= base_url("absensi/hadir/$a->id") ?>" class="badge badge-success">
                                                        <i class="ni ni-check-bold"></i>
                                                    </a>
                                                    <a href="<?= base_url("absensi/absen/$a->id") ?>" class="badge badge-danger">
                                                        <i class="ni ni-fat-remove"></i>
                                                    </a>
                                                </td>
                                            <?php } ?>
                                        </tr>
                                    <?php } ?>
                                <?php } else { ?>
                                    <tr>
                                        <td class="text-center" colspan="3">
                                            Kamu belum melakukan absensi, Buat <a href="<?php echo base_url() ?>absensi/create/<?php echo $jadwal[0]->id ?>"><strong>disini</strong></a>
                                        </td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer py-4">
                        <a href="<?php echo base_url() ?>absensi" class="btn btn-sm btn-danger">Kembali ke Jadwal</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>